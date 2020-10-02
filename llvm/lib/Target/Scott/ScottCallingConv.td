//===-- ScottCallingConv.td - Calling Conventions Scott ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the Scott CPU.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Scott Return Value Calling Convention
//===----------------------------------------------------------------------===//
def RetCC_Scott : CallingConv<[
  // Return in register R1
  CCIfType<[i16], CCAssignToReg<[R1]>>,

  // Integer values get stored in stack slots that are 1 bytes in
  // size and 1-byte aligned.
  CCIfType<[i16], CCAssignToStack<1, 1>>
]>;

//===----------------------------------------------------------------------===//
// Scott Argument Calling Conventions
//===----------------------------------------------------------------------===//
def CC_Scott : CallingConv<[
  // Pass by value if the byval attribute is given
  CCIfByVal<CCPassByVal<1, 1>>,

  // Regsiters used for parameters
  CCIfType<[i16], CCAssignToReg<[R0]>>,

  // Integer values get stored in stack slots that are 1 bytes in
  // size and 1-byte aligned.
  CCIfType<[i16], CCAssignToStack<1, 1>>
]>;

// Callee doesn't promise to save any registers.
def CC_Save : CalleeSavedRegs<(add)>;
