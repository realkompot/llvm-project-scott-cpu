//===-- llvm/MC/MCScottEmulatorObjectWriter.h - ScottEmulator Object Writer -------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_MC_MCSCOTTEMULATOROBJECTWRITER_H
#define LLVM_MC_MCSCOTTEMULATOROBJECTWRITER_H

#include "llvm/MC/MCObjectWriter.h"
#include <memory>

namespace llvm {

class MCFixup;
class MCValue;
class raw_pwrite_stream;

class MCScottEmulatorObjectTargetWriter : public MCObjectTargetWriter {
public:
  explicit MCScottEmulatorObjectTargetWriter();

  virtual ~MCScottEmulatorObjectTargetWriter();

  Triple::ObjectFormatType getFormat() const override { return Triple::ScottEmulator; }
  static bool classof(const MCObjectTargetWriter *W) {
    return W->getFormat() == Triple::ScottEmulator;
  }
};

std::unique_ptr<MCObjectWriter> createScottEmulatorObjectWriter(std::unique_ptr<MCScottEmulatorObjectTargetWriter> MOTW, raw_pwrite_stream &OS);

} // namespace llvm

#endif
