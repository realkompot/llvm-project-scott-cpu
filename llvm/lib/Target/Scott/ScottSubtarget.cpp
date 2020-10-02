//===-- ScottSubtarget.cpp - Scott Subtarget Information ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the Scott specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#include "ScottSubtarget.h"
#include "Scott.h"

#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "Scott-subtarget"

#define GET_SUBTARGETINFO_TARGET_DESC
#define GET_SUBTARGETINFO_CTOR
#include "ScottGenSubtargetInfo.inc"

void ScottSubtarget::anchor() { }

ScottSubtarget::ScottSubtarget(const Triple &TT, const std::string &CPU,
                               const std::string &FS, const TargetMachine &TM)
    : ScottGenSubtargetInfo(TT, CPU, FS),
      InstrInfo(*this), TLInfo(TM, *this),
      FrameLowering(*this) {}
