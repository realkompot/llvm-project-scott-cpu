//===-- ScottMCCodeEmitter.cpp - Convert Scott code to machine code -------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the ScottMCCodeEmitter class.
//
//===----------------------------------------------------------------------===//

#include "ScottMCTargetDesc.h"
#include "ScottFixupKinds.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCCodeEmitter.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/SubtargetFeature.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Endian.h"
#include "llvm/Support/EndianStream.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include <cassert>
#include <cstdint>

using namespace llvm;


#define DEBUG_TYPE "mccodeemitter"

STATISTIC(MCNumEmitted, "Number of MC instructions emitted");

namespace {
class ScottMCCodeEmitter : public MCCodeEmitter {
  ScottMCCodeEmitter(const ScottMCCodeEmitter &) = delete;
  void operator=(const ScottMCCodeEmitter &) = delete;
  const MCInstrInfo &MCII;
  const MCContext &CTX;

public:
  ScottMCCodeEmitter(const MCInstrInfo &MCII, MCContext &CTX)
      : MCII(MCII), CTX(CTX) {}

  ~ScottMCCodeEmitter() override {}

  void encodeInstruction(const MCInst &MI, raw_ostream &OS,
                         SmallVectorImpl<MCFixup> &Fixups,
                         const MCSubtargetInfo &STI) const override;

  /// TableGen'erated function for getting the binary encoding for an
  /// instruction.
  uint64_t getBinaryCodeForInstr(const MCInst &MI,
                                 SmallVectorImpl<MCFixup> &Fixups,
                                 const MCSubtargetInfo &STI) const;

  /// Return binary encoding of operand. If the machine operand requires
  /// relocation, record the relocation and return zero.
  unsigned getMachineOpValue(const MCInst &MI, const MCOperand &MO,
                             SmallVectorImpl<MCFixup> &Fixups,
                             const MCSubtargetInfo &STI) const;

  void emitByte(unsigned char C, raw_ostream &OS) const { OS << (char)C; }

  FeatureBitset computeAvailableFeatures(const FeatureBitset& FB) const;

  void verifyInstructionPredicates(const MCInst &Inst, const FeatureBitset &AvailableFeatures) const;
};
} // end anonymous namespace

unsigned ScottMCCodeEmitter::getMachineOpValue(const MCInst &MI,
                                    const MCOperand &MO,
                                    SmallVectorImpl<MCFixup> &Fixups,
                                    const MCSubtargetInfo &STI) const {

  if (MO.isReg()) {
    return CTX.getRegisterInfo()->getEncodingValue(MO.getReg());
  }

  if (MO.isImm()) {
    return static_cast<unsigned>(MO.getImm());
  }

  if (MO.isExpr()) {
    const MCExpr *Expr = MO.getExpr();
    MCExpr::ExprKind Kind = Expr->getKind();
    // Second half of instruction contains address.
    uint32_t Offset = 2;

    switch (Kind)
    {
      default:
        llvm_unreachable("Can't handle expression kind.");
      case MCExpr::Constant:
        return cast<MCConstantExpr>(Expr)->getValue();
      case MCExpr::SymbolRef:
        assert(cast<MCSymbolRefExpr>(Expr)->getKind() == MCSymbolRefExpr::VK_None && "Can't handle fixup kind.");
        Fixups.push_back(MCFixup::create(Offset, Expr, MCFixupKind(Scott::ScottOrdinaryFixup)));
        break;
      case MCExpr::Binary:
        const MCBinaryExpr *Binary = cast<MCBinaryExpr>(Expr);
        assert((Binary->getLHS()->getKind() == MCExpr::Constant ||
                Binary->getRHS()->getKind() == MCExpr::Constant) && "Expected constant expr.");
        Fixups.push_back(MCFixup::create(Offset, Expr, MCFixupKind(Scott::ScottOrdinaryFixup)));
        break;
    }

    return 0;
  }

  llvm_unreachable("Unhandled expression!");
  return 0;
}

void ScottMCCodeEmitter::encodeInstruction(const MCInst &MI, raw_ostream &OS,
                                         SmallVectorImpl<MCFixup> &Fixups,
                                         const MCSubtargetInfo &STI) const {
  const MCInstrDesc &Desc = MCII.get(MI.getOpcode());
  uint32_t Binary = getBinaryCodeForInstr(MI, Fixups, STI);

  // Emit in little-endian order.
  for (unsigned i = 0; i < Desc.getSize(); i++) {
    emitByte(Binary & 0xFF, OS);
    Binary = Binary >> 8;
  }

  ++MCNumEmitted;
}

#define ENABLE_INSTR_PREDICATE_VERIFIER
#include "ScottGenMCCodeEmitter.inc"

MCCodeEmitter *llvm::createScottMCCodeEmitter(const MCInstrInfo &MCII,
                                              const MCRegisterInfo &MRI,
                                              MCContext &Ctx) {
  return new ScottMCCodeEmitter(MCII, Ctx);
}
