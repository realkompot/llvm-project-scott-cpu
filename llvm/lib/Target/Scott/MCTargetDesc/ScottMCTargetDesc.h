//===-- ScottMCTargetDesc.h - Scott Target Descriptions ---------*- C++ -*-===//
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

#ifndef LLVM_LIB_TARGET_Scott_MCTARGETDESC_ScottMCTARGETDESC_H
#define LLVM_LIB_TARGET_Scott_MCTARGETDESC_ScottMCTARGETDESC_H

#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCTargetOptions.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/Support/DataTypes.h"

#include <memory>

namespace llvm {
class Target;
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectWriter;
class MCRegisterInfo;
class MCSubtargetInfo;

class StringRef;
class raw_ostream;
class raw_pwrite_stream;
class Triple;

Target &getTheScottTarget();

MCCodeEmitter *createScottMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        MCContext &Ctx);

MCAsmBackend *createScottAsmBackend(const Target &T,
                                    const MCSubtargetInfo &STI,
                                    const MCRegisterInfo &MRI,
                                    const MCTargetOptions &Options);
} // End llvm namespace

// Defines symbolic names for Scott registers.  This defines a mapping from
// register name to register number.
//
#define GET_REGINFO_ENUM
#include "ScottGenRegisterInfo.inc"

// Defines symbolic names for the Scott instructions.
//
#define GET_INSTRINFO_ENUM
#include "ScottGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "ScottGenSubtargetInfo.inc"

#endif
