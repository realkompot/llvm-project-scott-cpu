//===-- ScottRegisterInfo.h - Scott Register Information Impl ---*- C++ -*-===//
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

#ifndef LLVM_LIB_TARGET_Scott_ScottREGISTERINFO_H
#define LLVM_LIB_TARGET_Scott_ScottREGISTERINFO_H

#include "llvm/CodeGen/TargetRegisterInfo.h"

#define GET_REGINFO_HEADER
#include "ScottGenRegisterInfo.inc"

namespace llvm {
struct ScottRegisterInfo : public ScottGenRegisterInfo {
  ScottRegisterInfo();

  const TargetRegisterClass* getPointerRegClass(const MachineFunction &MF, unsigned Kind = 0) const override;

  const uint16_t *getCalleeSavedRegs(const MachineFunction *MF = 0) const override;

  BitVector getReservedRegs(const MachineFunction &MF) const override;

  void eliminateFrameIndex(MachineBasicBlock::iterator MI, int SPAdj,
                           unsigned FIOperandNum,
                           RegScavenger *RS = nullptr) const override;

  Register getFrameRegister(const MachineFunction &MF) const override;

  const uint32_t *getCallPreservedMask(const MachineFunction &MF, CallingConv::ID) const override;

private:
  void eliminateFrameIndexInAdd(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const;
  void eliminateFrameIndexInStore(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const;
  void eliminateFrameIndexInLoad(MachineBasicBlock::iterator II, unsigned FIOperandNum, int Offset) const;
};

} // end namespace llvm

#endif
