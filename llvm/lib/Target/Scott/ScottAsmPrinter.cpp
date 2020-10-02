//===-- ScottAsmPrinter.cpp - Scott LLVM assembly writer ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to GAS-format Scott assembly language.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/ScottInstPrinter.h"
#include "Scott.h"
#include "ScottInstrInfo.h"
#include "ScottMCInstLower.h"
#include "ScottTargetMachine.h"
#include "TargetInfo/ScottTargetInfo.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineModuleInfoImpls.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/IR/Mangler.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstBuilder.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "asm-printer"

namespace {
  class ScottAsmPrinter : public AsmPrinter {

  ScottMCInstLower MCInstLowering;

  public:
    explicit ScottAsmPrinter(TargetMachine &TM, std::unique_ptr<MCStreamer> Streamer)
        : AsmPrinter(TM, std::move(Streamer)), MCInstLowering(OutContext, *this) {
    }

    StringRef getPassName() const override {
        return StringRef("Scott Assembly Printer");
    }

    void emitFunctionEntryLabel() override;
    void emitInstruction(const MachineInstr *MI) override;
    void emitFunctionBodyStart() override;
    void expandCallInstruction(const MachineInstr *MI);
    void expandRetInstruction();
  };
} // end of anonymous namespace

void ScottAsmPrinter::emitFunctionBodyStart() {}

void ScottAsmPrinter::emitFunctionEntryLabel() {
  OutStreamer->emitLabel(CurrentFnSym);
}

void ScottAsmPrinter::expandCallInstruction(const MachineInstr *MI) {
  MCSymbol *RetSymbol = OutContext.createTempSymbol();
  const MCExpr *RetExpr = MCSymbolRefExpr::create(RetSymbol, OutContext);

  MCInst TmpInst;
  MCInstLowering.Lower(MI, TmpInst);

  // Address that SP points to will contain the return address.
  EmitToStreamer(*OutStreamer, MCInstBuilder(Scott::CPYri).addReg(Scott::TmpReg).addExpr(RetExpr));
  EmitToStreamer(*OutStreamer, MCInstBuilder(Scott::ST).addReg(Scott::TmpReg).addReg(Scott::SP));
  EmitToStreamer(*OutStreamer, MCInstBuilder(Scott::JMP).addOperand(TmpInst.getOperand(0)));
  OutStreamer->emitLabel(RetSymbol);
}

void ScottAsmPrinter::expandRetInstruction() {
  // Load return address to the temp reg and jump to it.
  EmitToStreamer(*OutStreamer, MCInstBuilder(Scott::LD).addReg(Scott::TmpReg).addReg(Scott::SP));
  EmitToStreamer(*OutStreamer, MCInstBuilder(Scott::JMPrr).addReg(Scott::TmpReg));
}

void ScottAsmPrinter::emitInstruction(const MachineInstr *MI) {
  MachineBasicBlock::const_instr_iterator I = MI->getIterator();
  MachineBasicBlock::const_instr_iterator E = MI->getParent()->instr_end();

  do {
    switch (I->getOpcode())
    {
      case Scott::CALL_PSEUDO:
        expandCallInstruction(&*I);
        return;
      case Scott::RET_PSEUDO:
        expandRetInstruction();
        return;
    }

    MCInst TmpInst;
    MCInstLowering.Lower(&*I, TmpInst);
    EmitToStreamer(*OutStreamer, TmpInst);

  } while ((++I != E) && I->isInsideBundle());
}

// Force static initialization.
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeScottAsmPrinter() {
  RegisterAsmPrinter<ScottAsmPrinter> X(getTheScottTarget());
}
