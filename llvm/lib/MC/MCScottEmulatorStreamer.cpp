//===- lib/MC/MCScottEmulatorStreamer.cpp - Scott Emulator Object Output ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file assembles .s files and emits ScottEmulator .o object files.
//
//===----------------------------------------------------------------------===//

#include "llvm/MC/MCScottEmulatorStreamer.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/MC/MCAsmBackend.h"
#include "llvm/MC/MCAsmLayout.h"
#include "llvm/MC/MCAssembler.h"
#include "llvm/MC/MCCodeEmitter.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCObjectStreamer.h"
#include "llvm/MC/MCSection.h"
#include "llvm/MC/MCSectionScottEmulator.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/MCSymbolScottEmulator.h"
#include "llvm/MC/MCValue.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

MCScottEmulatorStreamer::~MCScottEmulatorStreamer() = default;

void MCScottEmulatorStreamer::emitInstToData(const MCInst &Inst, const MCSubtargetInfo &STI) {
  MCDataFragment *DF = getOrCreateDataFragment();
  SmallVector<MCFixup, 4> Fixups;
  SmallString<256> Code;
  raw_svector_ostream VecOS(Code);
  getAssembler().getEmitter().encodeInstruction(Inst, VecOS, Fixups, STI);

  // Add the fixups and data.
  for (MCFixup &Fixup : Fixups) {
    Fixup.setOffset(Fixup.getOffset() + DF->getContents().size());
    DF->getFixups().push_back(Fixup);
  }
  DF->setHasInstructions(STI);
  DF->getContents().append(Code.begin(), Code.end());
}

bool MCScottEmulatorStreamer::emitSymbolAttribute(MCSymbol *S, MCSymbolAttr Attribute) {
  return true;
}

void MCScottEmulatorStreamer::emitCommonSymbol(MCSymbol *S, uint64_t Size, unsigned ByteAlignment) {
  llvm_unreachable("Not implemented.");
}

void MCScottEmulatorStreamer::emitZerofill(MCSection *Section, MCSymbol *Symbol,
                                  uint64_t Size, unsigned ByteAlignment,
                                  SMLoc Loc) {
  llvm_unreachable("Not implemented.");
}

void MCScottEmulatorStreamer::emitIntValue(uint64_t Value, unsigned Size)
{
  // Size is in 16-bit bytes, so emit as Size x 2 int.
  MCObjectStreamer::emitIntValue(Value, Size * 2);
}

void MCScottEmulatorStreamer::emitFill(const MCExpr &NumBytes, uint64_t FillValue, SMLoc Loc)
{
  // NumBytes is in 16-bit bytes, so emit twice.
  MCObjectStreamer::emitFill(NumBytes, FillValue, Loc);
  MCObjectStreamer::emitFill(NumBytes, FillValue, Loc);
}

MCStreamer *llvm::createScottEmulatorStreamer(MCContext &Context,
                                     std::unique_ptr<MCAsmBackend> &&MAB,
                                     std::unique_ptr<MCObjectWriter> &&OW,
                                     std::unique_ptr<MCCodeEmitter> &&CE,
                                     bool RelaxAll) {
  MCScottEmulatorStreamer *S = new MCScottEmulatorStreamer(Context, std::move(MAB), std::move(OW), std::move(CE));
  if (RelaxAll)
    S->getAssembler().setRelaxAll(true);
  return S;
}

