//===-- ScottTargetMachine.cpp - Define TargetMachine for Scott -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

#include "ScottTargetMachine.h"
#include "Scott.h"
#include "ScottTargetObjectFile.h"
#include "TargetInfo/ScottTargetInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeScottTarget() {
  // Register the target.
  RegisterTargetMachine<ScottTargetMachine> X(getTheScottTarget());
}

ScottTargetMachine::ScottTargetMachine(
    const Target &T, const Triple &TT, StringRef CPU, StringRef FS,
    const TargetOptions &Options, Optional<Reloc::Model> RM,
    Optional<CodeModel::Model> CM, CodeGenOpt::Level OL, bool JIT)
    : LLVMTargetMachine(T, "e-p:16:16:16-i16:16:16-n16-a:0:16", TT, CPU, FS, Options,
                        Reloc::Static, CodeModel::Small, OL),
      TLOF(std::make_unique<ScottTargetObjectFile>()),
      Subtarget(TT, std::string(CPU), std::string(FS), *this) {
  initAsmInfo();
}

ScottTargetMachine::~ScottTargetMachine() {}

const ScottSubtarget *ScottTargetMachine::getSubtargetImpl(const Function &F) const {
  return &Subtarget;
}

namespace {
/// Scott Code Generator Pass Configuration Options.
class ScottPassConfig : public TargetPassConfig {
public:
  ScottPassConfig(ScottTargetMachine &TM, PassManagerBase &PM)
    : TargetPassConfig(TM, PM) {}

  ScottTargetMachine &getScottTargetMachine() const {
    return getTM<ScottTargetMachine>();
  }

  bool addInstSelector() override;
  void addPreRegAlloc() override;
  void addPreEmitPass() override;
};
} // namespace

namespace llvm {
  FunctionPass *createBundleCmpJccPass();
  FunctionPass *createInsertClfPass();
  FunctionPass *createExpandSubtractionPass();
}

TargetPassConfig *ScottTargetMachine::createPassConfig(PassManagerBase &PM) {
  return new ScottPassConfig(*this, PM);
}

bool ScottPassConfig::addInstSelector() {
  addPass(llvm::createScottISelDag(getScottTargetMachine()));
  return false;
}

void ScottPassConfig::addPreRegAlloc()
{
  addPass(llvm::createBundleCmpJccPass());
}

void ScottPassConfig::addPreEmitPass()
{
  addPass(llvm::createInsertClfPass());
  addPass(llvm::createExpandSubtractionPass());
}
