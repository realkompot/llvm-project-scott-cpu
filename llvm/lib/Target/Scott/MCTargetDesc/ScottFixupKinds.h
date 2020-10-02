//===-- ScottFixupKinds.h - Scott Specific Fixup Entries ------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_Scott_FIXUPKINDS_H
#define LLVM_LIB_TARGET_Scott_FIXUPKINDS_H

#include "llvm/MC/MCFixup.h"

namespace llvm {
namespace Scott {

  // This table *must* be in the same order of
  // MCFixupKindInfo Infos[Scott::NumTargetFixupKinds]
  // in ScottAsmBackend.cpp.
  enum Fixups {
    ScottFixupNone = FirstTargetFixupKind,
    ScottOrdinaryFixup,
    // Marker
    LastTargetFixupKind,
    NumTargetFixupKinds = LastTargetFixupKind - FirstTargetFixupKind
  };
} // namespace Scott
} // namespace llvm


#endif
