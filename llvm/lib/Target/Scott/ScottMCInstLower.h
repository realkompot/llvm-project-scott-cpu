#ifndef LLVM_LIB_TARGET_Scott_ScottMCINSTLOWER_H
#define LLVM_LIB_TARGET_Scott_ScottMCINSTLOWER_H

#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/Support/Compiler.h"

namespace llvm {
class MCContext;
class MCInst;
class MCOperand;
class MachineInstr;
class MachineFunction;
class AsmPrinter;

class LLVM_LIBRARY_VISIBILITY ScottMCInstLower {
  MCContext &Ctx;
  AsmPrinter &Printer;

public:
  ScottMCInstLower(MCContext &Ctx, AsmPrinter &Printer)
  	: Ctx(Ctx), Printer(Printer) {}
  void Lower(const MachineInstr *MI, MCInst &OutMI) const;

  MCOperand LowerSymbolOperand(const MachineOperand &MO, MCSymbol *Sym) const;

  MCSymbol *GetGlobalAddressSymbol(const MachineOperand &MO) const;
};
}

#endif // LLVM_LIB_TARGET_Scott_ScottMCINSTLOWER_H
