//===-- ScottMCTargetDesc.cpp - Scott Target Descriptions -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides Scott specific target descriptions.
//
//===----------------------------------------------------------------------===//

#include "ScottMCTargetDesc.h"
#include "ScottInstPrinter.h"
#include "ScottMCAsmInfo.h"
#include "TargetInfo/ScottTargetInfo.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define GET_INSTRINFO_MC_DESC
#include "ScottGenInstrInfo.inc"

#define GET_SUBTARGETINFO_MC_DESC
#include "ScottGenSubtargetInfo.inc"

#define GET_REGINFO_MC_DESC
#include "ScottGenRegisterInfo.inc"


static MCInstrInfo *createScottMCInstrInfo() {
  MCInstrInfo *X = new MCInstrInfo();
  InitScottMCInstrInfo(X);
  return X;
}

static MCRegisterInfo *createScottMCRegisterInfo(const Triple &TT) {
  MCRegisterInfo *X = new MCRegisterInfo();
  InitScottMCRegisterInfo(X, Scott::PC);
  return X;
}

static MCAsmInfo *createScottMCAsmInfo(const MCRegisterInfo &MRI,
                                       const Triple &TT,
                                       const MCTargetOptions &Options) {
  return new ScottMCAsmInfo();
}

static MCInstPrinter *createScottMCInstPrinter(const Triple &TT, unsigned SyntaxVariant,
                       const MCAsmInfo &MAI, const MCInstrInfo &MII,
                       const MCRegisterInfo &MRI) {
  return new ScottInstPrinter(MAI, MII, MRI);
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeScottTargetMC() {
  RegisterMCAsmInfoFn X(getTheScottTarget(), createScottMCAsmInfo);
  TargetRegistry::RegisterMCInstrInfo(getTheScottTarget(), createScottMCInstrInfo);
  TargetRegistry::RegisterMCRegInfo(getTheScottTarget(), createScottMCRegisterInfo);
  TargetRegistry::RegisterMCAsmBackend(getTheScottTarget(), createScottAsmBackend);
  TargetRegistry::RegisterMCCodeEmitter(getTheScottTarget(), createScottMCCodeEmitter);
  TargetRegistry::RegisterMCSubtargetInfo(getTheScottTarget(), createScottMCSubtargetInfoImpl);
  TargetRegistry::RegisterMCInstPrinter(getTheScottTarget(), createScottMCInstPrinter);
}
