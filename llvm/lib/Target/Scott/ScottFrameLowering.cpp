//===-- ScottFrameLowering.cpp - Scott Frame Information ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the Scott implementation of TargetFrameLowering class.
//
//===----------------------------------------------------------------------===//

#include "ScottFrameLowering.h"
#include "ScottInstrInfo.h"
#include "ScottMachineFunctionInfo.h"
#include "ScottSubtarget.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Target/TargetOptions.h"

using namespace llvm;


ScottFrameLowering::ScottFrameLowering(const ScottSubtarget &ST)
    : TargetFrameLowering(TargetFrameLowering::StackGrowsDown, /*StackAlignment=*/Align(1), 0) {}

void ScottFrameLowering::emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB) const {
  // Compute the stack size, to determine if we need a prologue at all.
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
  const ScottMachineFunctionInfo *MFI = MF.getInfo<ScottMachineFunctionInfo>();
  MachineBasicBlock::iterator MBBI = MBB.begin();
  DebugLoc dl = MBBI != MBB.end() ? MBBI->getDebugLoc() : DebugLoc();

  uint64_t StackSize = MFI->calculateStackSize();
  if (!StackSize) {
    return;
  }

  // Adjust the stack register.
  unsigned StackReg = Scott::SP;
  unsigned OffsetReg = Scott::TmpReg;

  BuildMI(MBB, MBBI, dl, TII.get(Scott::CPYri), OffsetReg)
    .addImm(-StackSize);

  BuildMI(MBB, MBBI, dl, TII.get(Scott::ADDrr), StackReg)
    .addReg(OffsetReg, getKillRegState(OffsetReg))
    .addReg(OffsetReg, getKillRegState(OffsetReg))
    .setMIFlag(MachineInstr::FrameSetup);
}

void ScottFrameLowering::emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB) const {
  // Compute the stack size, to determine if we need an epilogue at all.
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
  const ScottMachineFunctionInfo *MFI = MF.getInfo<ScottMachineFunctionInfo>();
  MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
  DebugLoc dl = MBBI->getDebugLoc();
  uint64_t StackSize = MFI->calculateStackSize();
  if (!StackSize) {
    return;
  }

  // Restore the stack register to what it was at the beginning of the function.
  unsigned StackReg = Scott::SP;
  unsigned OffsetReg = Scott::TmpReg;

  BuildMI(MBB, MBBI, dl, TII.get(Scott::CPYri), OffsetReg)
    .addImm(StackSize);

  // Adding two positive ints, no clf required.
  BuildMI(MBB, MBBI, dl, TII.get(Scott::NO_CLF_ADDrr), StackReg)
    .addReg(OffsetReg, getKillRegState(OffsetReg))
    .addReg(OffsetReg, getKillRegState(OffsetReg))
    .setMIFlag(MachineInstr::FrameDestroy);
}

bool ScottFrameLowering::canSimplifyCallFramePseudos(const MachineFunction &MF) const {
  return true;
}

MachineBasicBlock::iterator ScottFrameLowering::eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB, MachineBasicBlock::iterator I) const {
  return MBB.erase(I);
}

bool ScottFrameLowering::hasFP(const MachineFunction &MF) const { return false; }

