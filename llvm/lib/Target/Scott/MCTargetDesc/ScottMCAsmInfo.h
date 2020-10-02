//===- ScottMCAsmInfo.h - Scott asm properties -----------------*- C++ -*--===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the ScottMCAsmInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_Scott_MCTARGETDESC_ScottMCASMINFO_H
#define LLVM_LIB_TARGET_Scott_MCTARGETDESC_ScottMCASMINFO_H

#include "llvm/MC/MCAsmInfoELF.h"

namespace llvm {

class Triple;

class ScottMCAsmInfo : public MCAsmInfo {
  virtual void anchor();

public:
  explicit ScottMCAsmInfo();
};

}

#endif // LLVM_LIB_TARGET_Scott_MCTARGETDESC_ScottMCASMINFO_H
