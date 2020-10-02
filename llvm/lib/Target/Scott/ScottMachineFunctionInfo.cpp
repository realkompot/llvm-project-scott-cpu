//===-- ScottMachineFunctionInfo.cpp - Scott Machine Function Info --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "ScottMachineFunctionInfo.h"
#include "llvm/CodeGen/MachineFrameInfo.h"


using namespace llvm;

void ScottMachineFunctionInfo::anchor() { }

uint64_t ScottMachineFunctionInfo::calculateStackSize() const
{
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  uint64_t StackSize = MFI.getStackSize();

  assert(!MF.getFrameInfo().hasVarSizedObjects() && "Var sized objects are not supported!");

  return StackSize + ExtraSpaceForReturnAddress;
}

uint64_t ScottMachineFunctionInfo::calculateStackSlotOffset(int FrameIndex) const
{
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  // In case of negative frame index (accessing data on the lower stack frame)
  // we need to hop over the other function's return address slot.
  const int Multiplier = FrameIndex >= 0 ? 1 : 2;

  return MFI.getObjectOffset(FrameIndex) + MFI.getStackSize() + Multiplier * ExtraSpaceForReturnAddress;
}
