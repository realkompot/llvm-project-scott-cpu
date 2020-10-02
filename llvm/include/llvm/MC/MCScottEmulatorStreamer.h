//===- MCScottEmulatorStreamer.h - MCStreamer ScottEmulator Object File Interface -*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_MC_MCSCOTTEMULATORSTREAMER_H
#define LLVM_MC_MCSCOTTEMULATORSTREAMER_H

#include "MCAsmBackend.h"
#include "MCCodeEmitter.h"
#include "llvm/MC/MCDirectives.h"
#include "llvm/MC/MCObjectStreamer.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/Support/DataTypes.h"

namespace llvm {
class MCExpr;
class MCInst;

class MCScottEmulatorStreamer : public MCObjectStreamer
{
public:
  MCScottEmulatorStreamer(MCContext &Context, std::unique_ptr<MCAsmBackend> TAB,
                 std::unique_ptr<MCObjectWriter> OW,
                 std::unique_ptr<MCCodeEmitter> Emitter)
      : MCObjectStreamer(Context, std::move(TAB), std::move(OW),
                         std::move(Emitter)) {}

  ~MCScottEmulatorStreamer() override;

  bool emitSymbolAttribute(MCSymbol *Symbol, MCSymbolAttr Attribute) override;
  void emitInstToData(const MCInst &Inst, const MCSubtargetInfo &) override;
  void emitIntValue(uint64_t Value, unsigned Size) override;
  void emitCommonSymbol(MCSymbol *Symbol, uint64_t Size, unsigned ByteAlignment) override;
  void emitZerofill(MCSection *Section, MCSymbol *Symbol = nullptr, uint64_t Size = 0, unsigned ByteAlignment = 0, SMLoc Loc = SMLoc()) override;
  void emitFill(const MCExpr &NumBytes, uint64_t FillValue, SMLoc Loc) override;
};

} // end namespace llvm

#endif
