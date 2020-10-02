//===-- ScottTargetObjectFile.h - Scott Object Info -------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_Scott_ScottTARGETOBJECTFILE_H
#define LLVM_LIB_TARGET_Scott_ScottTARGETOBJECTFILE_H

#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"

namespace llvm {

class MCContext;
class TargetMachine;

class ScottTargetObjectFile : public TargetLoweringObjectFileScottEmulator {
public:
  ScottTargetObjectFile() : TargetLoweringObjectFileScottEmulator() {}

  void Initialize(MCContext &Ctx, const TargetMachine &TM) override;
};

} // end namespace llvm

#endif
