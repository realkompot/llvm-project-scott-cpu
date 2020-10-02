//===- MCSymbolScottEmulator.h -  ----------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#ifndef LLVM_MC_MCSYMBOLSCOTTEMULATOR_H
#define LLVM_MC_MCSYMBOLSCOTTEMULATOR_H

#include "llvm/MC/MCSymbol.h"

namespace llvm {

class MCSymbolScottEmulator : public MCSymbol {
  /// An expression describing how to calculate the size of a symbol. If a
  /// symbol has no size this field will be NULL.
  const MCExpr *SymbolSize = nullptr;

public:
  MCSymbolScottEmulator(const StringMapEntry<bool> *Name, bool isTemporary)
      : MCSymbol(SymbolKindScottEmulator, Name, isTemporary) {}
  void setSize(const MCExpr *SS) { SymbolSize = SS; }

  const MCExpr *getSize() const { return SymbolSize; }

  static bool classof(const MCSymbol *S) { return S->isScottEmulator(); }
};

} // end namespace llvm

#endif // LLVM_MC_MCSYMBOLSCOTTEMULATOR_H
