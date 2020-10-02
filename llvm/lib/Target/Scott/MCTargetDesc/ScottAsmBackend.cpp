//===-- ScottAsmBackend.cpp - Scott Assembler Backend ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/ScottMCTargetDesc.h"
#include "MCTargetDesc/ScottFixupKinds.h"
#include "llvm/MC/MCAsmBackend.h"
#include "llvm/MC/MCELFObjectWriter.h"
#include "llvm/MC/MCScottEmulatorObjectWriter.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCFixupKindInfo.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCValue.h"
#include "llvm/Support/EndianStream.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;


namespace {
class ScottAsmBackend : public MCAsmBackend {

public:
  ScottAsmBackend() : MCAsmBackend(support::little) {}

  ~ScottAsmBackend() {}

  bool writeNopData(raw_ostream &OS, uint64_t Count) const override;

  unsigned getNumFixupKinds() const override {
    return Scott::NumTargetFixupKinds;
  }

  const MCFixupKindInfo &getFixupKindInfo(MCFixupKind Kind) const override {
    const static MCFixupKindInfo Infos[Scott::NumTargetFixupKinds] = {
      // This table *must* be in the order that the fixup_* kinds are defined in ScottFixupKinds.h.
      // Name            Offset (bits) Size (bits)     Flags
      { "ScottFixupNone",     0,  16,   0 },
      { "ScottOrdinaryFixup", 0,  16,   0 },
    };

    if (Kind < FirstTargetFixupKind) {
      return MCAsmBackend::getFixupKindInfo(Kind);
    }

    assert(unsigned(Kind - FirstTargetFixupKind) < getNumFixupKinds() && "Invalid kind!");

    return Infos[Kind - FirstTargetFixupKind];
  }

  std::unique_ptr<MCObjectTargetWriter> createObjectTargetWriter() const override;

  void applyFixup(const MCAssembler &Asm, const MCFixup &Fixup,
                  const MCValue &Target, MutableArrayRef<char> Data,
                  uint64_t Value, bool IsResolved,
                  const MCSubtargetInfo *STI) const override;

  bool fixupNeedsRelaxation(const MCFixup &Fixup, uint64_t Value,
                            const MCRelaxableFragment *DF,
                            const MCAsmLayout &Layout) const override {
    return false;
  }
};

bool ScottAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count) const {
  // We can't write nops.
  return !Count;
}

std::unique_ptr<MCObjectTargetWriter> ScottAsmBackend::createObjectTargetWriter() const {
  return std::make_unique<MCScottEmulatorObjectTargetWriter>();
}

} // end anonymous namespace

void ScottAsmBackend::applyFixup(const MCAssembler &Asm, const MCFixup &Fixup,
                  const MCValue &Target, MutableArrayRef<char> Data,
                  uint64_t Value, bool IsResolved,
                  const MCSubtargetInfo *STI) const {
  if (!Value) {
    return;
  }

  // Address offset to make adjustments to.
  // Simply store 2 bytes of the value.
  unsigned Offset = Fixup.getOffset();
  Data[Offset] = Value & 0xFF;
  Data[Offset + 1] = uint8_t((Value >> 8) & 0xFF);

  return;
}

MCAsmBackend *llvm::createScottAsmBackend(const Target &T,
                                          const MCSubtargetInfo &STI,
                                          const MCRegisterInfo &MRI,
                                          const MCTargetOptions &Options) {
  return new ScottAsmBackend();
}
