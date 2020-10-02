//===- lib/MC/ScottEmulatorObjectWriter.cpp - ScottEmulator File Writer ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements ScottEmulator object file writer information.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/BinaryFormat/ScottEmulator.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/MC/MCAsmBackend.h"
#include "llvm/MC/MCAsmLayout.h"
#include "llvm/MC/MCAssembler.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCFixupKindInfo.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/MC/MCSectionScottEmulator.h"
#include "llvm/MC/MCSymbolScottEmulator.h"
#include "llvm/MC/MCValue.h"
#include "llvm/MC/MCScottEmulatorObjectWriter.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/EndianStream.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/LEB128.h"
#include "llvm/Support/StringSaver.h"
#include <vector>

using namespace llvm;

#define DEBUG_TYPE "mc"

namespace {

struct ScottRelocationEntry {
  const uint64_t Offset;
  const uint64_t FixedValue;
  const MCSection *FixupSection;

  ScottRelocationEntry(uint64_t Offset, int64_t FixedValue, const MCSection *FixupSection)
      : Offset(Offset), FixedValue(FixedValue),
        FixupSection(FixupSection) {}
};

class ScottEmulatorObjectWriter : public MCObjectWriter {
  support::endian::Writer W;
  std::unique_ptr<MCScottEmulatorObjectTargetWriter> TargetObjectWriter;
  std::vector<ScottRelocationEntry> Relocations;
public:
  ScottEmulatorObjectWriter(std::unique_ptr<MCScottEmulatorObjectTargetWriter> MOTW, raw_pwrite_stream &OS)
      : W(OS, support::little), TargetObjectWriter(std::move(MOTW)) {}


  void recordRelocation(MCAssembler &Asm, const MCAsmLayout &Layout,
                        const MCFragment *Fragment, const MCFixup &Fixup,
                        MCValue Target, uint64_t &FixedValue) override;

  void executePostLayoutBinding(MCAssembler &Asm, const MCAsmLayout &Layout) override;

  uint64_t writeObject(MCAssembler &Asm, const MCAsmLayout &Layout) override;
};

void ScottEmulatorObjectWriter::recordRelocation(MCAssembler &Asm,
                                        const MCAsmLayout &Layout,
                                        const MCFragment *Fragment,
                                        const MCFixup &Fixup, MCValue Target,
                                        uint64_t &FixedValue) {
  const MCExpr *Expr = Fixup.getValue();
  const MCBinaryExpr *Binary = dyn_cast_or_null<MCBinaryExpr>(Expr);
  const MCConstantExpr *RhsConstant = dyn_cast_or_null<MCConstantExpr>(Binary ? Binary->getRHS() : nullptr);

  uint64_t FixupOffset = Layout.getFragmentOffset(Fragment) + Fixup.getOffset();
  uint64_t ValueToRecord = FixedValue;

  // Compensate for double byte size.
  if (RhsConstant)
    ValueToRecord += RhsConstant->getValue();

  ScottRelocationEntry RelocationEntry(FixupOffset, ValueToRecord, Fragment->getParent());

  Relocations.push_back(RelocationEntry);
}

void ScottEmulatorObjectWriter::executePostLayoutBinding(MCAssembler &Asm, const MCAsmLayout &Layout) {}

static void patchI16(raw_pwrite_stream &Stream, uint16_t X, uint64_t Offset) {
  uint8_t Buffer[2];
  support::endian::write16le(Buffer, X);
  Stream.pwrite((char *)Buffer, sizeof(Buffer), Offset);
}

uint64_t ScottEmulatorObjectWriter::writeObject(MCAssembler &Asm, const MCAsmLayout &Layout) {
  uint64_t StartOffset = W.OS.tell();
  W.OS.write(scott::InitialSPValueInstrBytes, sizeof(scott::InitialSPValueInstrBytes));

  // Write the section.
  assert(Asm.size() == 1 && "Single section is expected");
  const MCSection &Section = *Asm.begin();
  Asm.writeSectionData(W.OS, &Section, Layout);

  // Patch fixups according to emulator rules.
  raw_pwrite_stream &Stream = static_cast<raw_pwrite_stream&>(W.OS);

  for (const ScottRelocationEntry &Relocation : Relocations)
  {
    uint16_t value = scott::calculateEmulatorAddress(Relocation.FixedValue);
    patchI16(Stream, value, Relocation.Offset + sizeof(scott::InitialSPValueInstrBytes));
  }

  return W.OS.tell() - StartOffset;
}

} // end anonymous namespace

std::unique_ptr<MCObjectWriter> llvm::createScottEmulatorObjectWriter(
    std::unique_ptr<MCScottEmulatorObjectTargetWriter> MOTW, raw_pwrite_stream &OS) {
  return std::make_unique<ScottEmulatorObjectWriter>(std::move(MOTW), OS);
}

