//===- ScottMachineFunctionInfo.h - Scott Machine Function Info -*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares  Scott specific per-machine-function information.
//
//===----------------------------------------------------------------------===//
#ifndef LLVM_LIB_TARGET_Scott_ScottMACHINEFUNCTIONINFO_H
#define LLVM_LIB_TARGET_Scott_ScottMACHINEFUNCTIONINFO_H

#include "llvm/CodeGen/MachineFunction.h"

namespace llvm {

class ScottMachineFunctionInfo : public MachineFunctionInfo {
  virtual void anchor();
  const MachineFunction &MF;

public:
  // Reserved for return address.
  int const static ExtraSpaceForReturnAddress = 1;

  explicit ScottMachineFunctionInfo(const MachineFunction &MF) : MF(MF) {}
  uint64_t calculateStackSize() const;
  uint64_t calculateStackSlotOffset(int FrameIndex) const;
};

}

#endif
