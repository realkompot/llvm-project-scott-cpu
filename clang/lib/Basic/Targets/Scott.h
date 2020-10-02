//===--- Scott.h - Declare Scott target feature support -------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares Scott TargetInfo objects.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_BASIC_TARGETS_SCOTT_H
#define LLVM_CLANG_LIB_BASIC_TARGETS_SCOTT_H

#include "clang/Basic/TargetInfo.h"
#include "clang/Basic/TargetOptions.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Support/Compiler.h"

namespace clang {
namespace targets {

class LLVM_LIBRARY_VISIBILITY ScottTargetInfo : public TargetInfo {
public:
  ScottTargetInfo(const llvm::Triple &Triple, const TargetOptions &)
      : TargetInfo(Triple) {
    NoAsmVariants = true;
    IntWidth = 16;
    LongWidth = 16;
    BoolWidth = 16;
    LongLongWidth = 16;
    IntAlign = LongAlign = BoolAlign = LongLongAlign = 16;
    SuitableAlign = 16;
    DoubleAlign = LongDoubleAlign = 16;
    PointerWidth = PointerAlign = 16;
    SizeType = UnsignedShort;
    PtrDiffType = SignedShort;
    IntPtrType = SignedShort;
    UseZeroLengthBitfieldAlignment = true;
    resetDataLayout("e-p:16:16:16-i16:16:16-n16-a:0:16");
  }

  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;

  ArrayRef<Builtin::Info> getTargetBuiltins() const override { return None; }

  BuiltinVaListKind getBuiltinVaListKind() const override {
    return TargetInfo::VoidPtrBuiltinVaList;
  }

  const char *getClobbers() const override { return ""; }

  ArrayRef<const char *> getGCCRegNames() const override {
    static const char *const GCCRegNames[] = {
        "R0",  "R1",  "R2",  "R3"};
    return llvm::makeArrayRef(GCCRegNames);
  }

  ArrayRef<TargetInfo::GCCRegAlias> getGCCRegAliases() const override {
    return None;
  }

  bool validateAsmConstraint(const char *&Name,
                             TargetInfo::ConstraintInfo &Info) const override {
    return false;
  }
};

} // namespace targets
} // namespace clang

#endif // LLVM_CLANG_LIB_BASIC_TARGETS_SCOTT_H
