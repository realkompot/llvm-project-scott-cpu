//===- lib/MC/MCSectionWasm.cpp - Wasm Code Section Representation --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/MC/MCSectionScottEmulator.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/MCSymbolScottEmulator.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

MCSectionScottEmulator::MCSectionScottEmulator(StringRef Name, SectionKind K, MCSymbol *Begin)
    : MCSection(SV_ScottEmulator, Name, K, Begin) {}

MCSectionScottEmulator::~MCSectionScottEmulator() {} // anchor.

void MCSectionScottEmulator::PrintSwitchToSection(const MCAsmInfo &MAI, const Triple &T,
                                         raw_ostream &OS,
                                         const MCExpr *Subsection) const { }
