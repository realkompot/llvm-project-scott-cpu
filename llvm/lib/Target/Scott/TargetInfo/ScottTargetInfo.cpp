//===-- ScottTargetInfo.cpp - Scott Target Implementation -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TargetInfo/ScottTargetInfo.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target &llvm::getTheScottTarget() {
  static Target TheScottTarget;
  return TheScottTarget;
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeScottTargetInfo() {
  RegisterTarget<Triple::scott, /*HasJIT=*/false> X(getTheScottTarget(), "scott",
                                                   "Scott CPU", "scott");
}
