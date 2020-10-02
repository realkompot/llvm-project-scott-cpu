//===-- ScottInstrInfo.cpp - Scott Instruction Information ----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the Scott implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#include "ScottInstrInfo.h"
#include "Scott.h"
#include "ScottMachineFunctionInfo.h"
#include "ScottSubtarget.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define GET_INSTRINFO_CTOR_DTOR
#include "ScottGenInstrInfo.inc"

// Pin the vtable to this file.
void ScottInstrInfo::anchor() {}

ScottInstrInfo::ScottInstrInfo(ScottSubtarget &ST)
    : ScottGenInstrInfo(Scott::ADJCALLSTACKDOWN, Scott::ADJCALLSTACKUP), RI(),
      Subtarget(ST) {}

MachineBasicBlock::instr_iterator findConditionalJumpInBundle(MachineBasicBlock::iterator I)
{
  auto II = I->getIterator();
  while (II->getOpcode() != Scott::JCC && II->isBundledWithSucc())
    II++;

  assert(II->getOpcode() == Scott::JCC && "Expected to find JCC");
  return II;
}

unsigned ScottInstrInfo::insertBranch(MachineBasicBlock &MBB,
                                      MachineBasicBlock *TBB,
                                      MachineBasicBlock *FBB,
                                      ArrayRef<MachineOperand> Cond,
                                      const DebugLoc &DL,
                                      int *BytesAdded) const {
  // Shouldn't be a fall through.
  assert(TBB && "insertBranch must not be told to insert a fallthrough");
  assert((Cond.size() == 1 || Cond.size() == 0) &&
         "Scott branch conditions have one component!");
  assert(!BytesAdded && "code size not handled");

  if (Cond.empty()) {
    // Unconditional branch?
    assert(!FBB && "Unconditional branch with multiple successors!");
    BuildMI(&MBB, DL, get(Scott::JMP)).addMBB(TBB);
    return 1;
  }

  MachineBasicBlock::const_iterator LastInstr = MBB.end();
  LastInstr--;
  assert(LastInstr->getOpcode() == Scott::CMPrr && "Expected CMP before inserting JCC");

  // Conditional branch.
  unsigned Count = 0;
  BuildMI(&MBB, DL, get(Scott::JCC))
    .addMBB(TBB)
    .addImm(Cond[0].getImm());

  ++Count;

  if (FBB) {
    // Two-way Conditional branch. Insert the second branch.
    BuildMI(&MBB, DL, get(Scott::JMP)).addMBB(FBB);
    ++Count;
  }
  return Count;
}

unsigned ScottInstrInfo::removeBranch(MachineBasicBlock &MBB,
                                      int *BytesRemoved) const {
  assert(!BytesRemoved && "code size not handled");

  MachineBasicBlock::iterator I = MBB.end();
  unsigned Count = 0;

  while (I != MBB.begin()) {
    --I;
    if (I->isDebugValue())
      continue;

    if (I->getOpcode() != Scott::JMP &&
        I->getOpcode() != Scott::JCC &&
        (!I->isBundled() || !I->isBranch()))
      break;

    if (I->isBundled()) {
      auto JCC = findConditionalJumpInBundle(I);
      JCC->eraseFromBundle();
    } else {
      I->eraseFromParent();
    }

    I = MBB.end();
    ++Count;
  }

  return Count;
}

void ScottInstrInfo::copyPhysReg(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator I,
                                 const DebugLoc &DL, MCRegister DestReg,
                                 MCRegister SrcReg, bool KillSrc) const {
  if (Scott::GPRegsRegClass.contains(DestReg, SrcReg)) {
      BuildMI(MBB, I, DL, get(Scott::XORrr), DestReg)
        .addReg(DestReg)
        .addReg(DestReg);

      BuildMI(MBB, I, DL, get(Scott::NO_CLF_ADDrr), DestReg)
        .addReg(SrcReg, getKillRegState(KillSrc))
        .addReg(SrcReg, getKillRegState(KillSrc));
  }
  else {
    llvm_unreachable("Impossible reg-to-reg copy");
  }
}

void ScottInstrInfo::storeRegToStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                    Register SrcReg, bool isKill, int FI,
                    const TargetRegisterClass *RC,
                    const TargetRegisterInfo *TRI) const {
  BuildMI(MBB, MI, DebugLoc(), get(Scott::ST))
    .addReg(SrcReg, getKillRegState(isKill))
    .addFrameIndex(FI);
}

void ScottInstrInfo::loadRegFromStackSlot(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                     Register DestReg, int FI,
                     const TargetRegisterClass *RC,
                     const TargetRegisterInfo *TRI) const {
  BuildMI(MBB, MI, DebugLoc(), get(Scott::LD), DestReg)
      .addFrameIndex(FI);
}

bool ScottInstrInfo::isUnpredicatedTerminator(const MachineInstr &MI) const {
  if (!MI.isTerminator())
    return false;

  // Conditional branch is a special case.
  if (MI.isBranch() && !MI.isBarrier())
    return true;
  if (!MI.isPredicable())
    return true;
  return !isPredicated(MI);
}

bool ScottInstrInfo::analyzeBranch(MachineBasicBlock &MBB,
                                 MachineBasicBlock *&TBB,
                                 MachineBasicBlock *&FBB,
                                 SmallVectorImpl<MachineOperand> &Cond,
                                 bool AllowModify) const {
  // Start from the bottom of the block and work up, examining the
  // terminator instructions.
  MachineBasicBlock::iterator I = MBB.end();
  while (I != MBB.begin()) {
    --I;
    if (I->isDebugValue())
      continue;

    // Working from the bottom, when we see a non-terminator
    // instruction, we're done.
    if (!isUnpredicatedTerminator(*I))
      break;

    // A terminator that isn't a branch can't easily be handled
    // by this analysis.
    if (!I->isBranch())
      return true;

    // Handle unconditional branches.
    if (I->getOpcode() == Scott::JMP) {
      if (!AllowModify) {
        TBB = I->getOperand(0).getMBB();
        continue;
      }

      // If the block has any instructions after a JMP, delete them.
      while (std::next(I) != MBB.end())
        std::next(I)->eraseFromParent();
      Cond.clear();
      FBB = nullptr;

      // Delete the JMP if it's equivalent to a fall-through.
      if (MBB.isLayoutSuccessor(I->getOperand(0).getMBB())) {
        TBB = nullptr;
        I->eraseFromParent();
        I = MBB.end();
        continue;
      }

      // TBB is used to indicate the unconditinal destination.
      TBB = I->getOperand(0).getMBB();
      continue;
    }

    unsigned Opcode = I->getOpcode();
    MachineOperand *BranchTarget = nullptr;
    MachineOperand *CondCode = nullptr;

    if (I->isBundled())
    {
      auto JCC = findConditionalJumpInBundle(I);
      Opcode = JCC->getOpcode();
      BranchTarget = &JCC->getOperand(0);
      CondCode = &JCC->getOperand(1);
    }else {
      BranchTarget = &I->getOperand(0);
      CondCode = &I->getOperand(1);
    }

    // Handle conditional branches.
    assert(Opcode == Scott::JCC && "Invalid conditional branch");
    ScottCC::CondCodes BranchCode =
      static_cast<ScottCC::CondCodes>(CondCode->getImm());
    if (BranchCode == ScottCC::COND_INVALID)
      return true;  // Can't handle weird stuff.

    // Working from the bottom, handle the first conditional branch.
    if (Cond.empty()) {
      FBB = TBB;
      TBB = BranchTarget->getMBB();
      Cond.push_back(MachineOperand::CreateImm(BranchCode));
      continue;
    }

    // Handle subsequent conditional branches. Only handle the case where all
    // conditional branches branch to the same destination.
    assert(Cond.size() == 1);
    assert(TBB);

    // Only handle the case where all conditional branches branch to
    // the same destination.
    if (TBB != BranchTarget->getMBB())
      return true;

    ScottCC::CondCodes OldBranchCode = (ScottCC::CondCodes)Cond[0].getImm();
    // If the conditions are the same, we can leave them alone.
    if (OldBranchCode == BranchCode)
      continue;

    return true;
  }

  return false;
}
