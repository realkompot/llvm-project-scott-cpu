//===-- ScottFrameLowering.h - Define frame lowering for Scott --*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_Scott_ScottFRAMELOWERING_H
#define LLVM_LIB_TARGET_Scott_ScottFRAMELOWERING_H

#include "Scott.h"
#include "llvm/CodeGen/TargetFrameLowering.h"

namespace llvm {

class ScottSubtarget;
class ScottFrameLowering : public TargetFrameLowering {
public:
  explicit ScottFrameLowering(const ScottSubtarget &ST);

  void emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB) const override;

  void emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB) const override;

  MachineBasicBlock::iterator eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB, MachineBasicBlock::iterator I) const override;

  bool hasFP(const MachineFunction &MF) const override;

  bool canSimplifyCallFramePseudos(const MachineFunction &MF) const override;
private:
};

} // End llvm namespace

#endif
