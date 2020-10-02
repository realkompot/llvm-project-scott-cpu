//===-- ScottRegisterInfo.cpp - Scott Register Information ----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the Scott implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#include "ScottRegisterInfo.h"
#include "Scott.h"
#include "ScottMachineFunctionInfo.h"
#include "ScottSubtarget.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"

using namespace llvm;

#define GET_REGINFO_TARGET_DESC
#include "ScottGenRegisterInfo.inc"

ScottRegisterInfo::ScottRegisterInfo() : ScottGenRegisterInfo(Scott::PC) {}

const MCPhysReg *ScottRegisterInfo::getCalleeSavedRegs(const MachineFunction *MF) const {
  return CC_Save_SaveList;
}

const uint32_t *ScottRegisterInfo::getCallPreservedMask(const MachineFunction &MF, CallingConv::ID) const {
  return CC_Save_RegMask;
};

BitVector ScottRegisterInfo::getReservedRegs(const MachineFunction &MF) const {
  BitVector Reserved(getNumRegs());

  Reserved.set(Scott::SP);
  Reserved.set(Scott::FR);
  Reserved.set(Scott::PC);

  return Reserved;
}

const TargetRegisterClass *ScottRegisterInfo::getPointerRegClass(const MachineFunction &MF, unsigned Kind) const {
  return &Scott::GPRegsRegClass;
}

void ScottRegisterInfo::eliminateFrameIndexInAdd(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const
{
  MachineInstr &MI = *II;
  MachineFunction &MF = *MI.getParent()->getParent();
  Register ReturnValueReg = MI.getOperand(0).getReg();
  Register FrameReg = getFrameRegister(MF);
  const ScottInstrInfo *TII = MF.getSubtarget<ScottSubtarget>().getInstrInfo();

  BuildMI(*MI.getParent(), II, DebugLoc(), TII->get(Scott::CPYri), ReturnValueReg)
    .addImm(Offset);

  MI.getOperand(FIOperandNum).ChangeToRegister(ReturnValueReg, false, false, false);
  MI.getOperand(FIOperandNum + 1).setReg(FrameReg);
}

void ScottRegisterInfo::eliminateFrameIndexInStore(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const
{
  MachineInstr &MI = *II;
  MachineFunction &MF = *MI.getParent()->getParent();
  MachineBasicBlock &MBB = *MI.getParent();
  Register RegisterToStore = MI.getOperand(0).getReg();
  Register FrameReg = getFrameRegister(MF);
  const ScottInstrInfo *TII = MF.getSubtarget<ScottSubtarget>().getInstrInfo();

  BuildMI(MBB, II, DebugLoc(), TII->get(Scott::CPYri), Scott::TmpReg)
    .addImm(Offset);

  BuildMI(MBB, II, DebugLoc(), TII->get(Scott::NO_CLF_ADDrr), Scott::TmpReg)
    .addReg(Scott::TmpReg)
    .addReg(FrameReg);

  MI.getOperand(0).setReg(RegisterToStore);
  MI.getOperand(FIOperandNum).ChangeToRegister(Scott::TmpReg, false, false, true);
}

void ScottRegisterInfo::eliminateFrameIndexInLoad(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const
{
  MachineInstr &MI = *II;
  MachineFunction &MF = *MI.getParent()->getParent();
  MachineBasicBlock &MBB = *MI.getParent();
  Register FrameReg = getFrameRegister(MF);
  const ScottInstrInfo *TII = MF.getSubtarget<ScottSubtarget>().getInstrInfo();
  Register RegisterToLoad = MI.getOperand(0).getReg();

  BuildMI(MBB, II, DebugLoc(), TII->get(Scott::CPYri), RegisterToLoad)
    .addImm(Offset);

  BuildMI(MBB, II, DebugLoc(), TII->get(Scott::NO_CLF_ADDrr), RegisterToLoad)
    .addReg(RegisterToLoad)
    .addReg(FrameReg);

  MI.getOperand(0).setReg(RegisterToLoad);
  MI.getOperand(FIOperandNum).ChangeToRegister(RegisterToLoad, false, false, true);
}

void ScottRegisterInfo::eliminateFrameIndex(MachineBasicBlock::iterator II,
                                          int SPAdj, unsigned FIOperandNum,
                                          RegScavenger *RS) const {
  assert(SPAdj == 0 && "Unexpected non-zero SPAdj value");

  MachineInstr &MI = *II;
  MachineFunction &MF = *MI.getParent()->getParent();
  const ScottMachineFunctionInfo *MFI = MF.getInfo<ScottMachineFunctionInfo>();

  int FrameIndex = MI.getOperand(FIOperandNum).getIndex();
  int Offset = MFI->calculateStackSlotOffset(FrameIndex);

  if (Offset < 0) {
    report_fatal_error("Negative frame index offset!");
  }

  switch (MI.getOpcode()) {
    case Scott::NO_CLF_ADDrr:
      eliminateFrameIndexInAdd(II, FIOperandNum, Offset);
    break;
    case Scott::ST:
      eliminateFrameIndexInStore(II, FIOperandNum, Offset);
    break;
    case Scott::LD:
      eliminateFrameIndexInLoad(II, FIOperandNum, Offset);
    break;
  }
}

Register ScottRegisterInfo::getFrameRegister(const MachineFunction &MF) const {
  return Scott::SP;
}
