#include "ScottTargetMachine.h"
#include "Scott.h"
#include "ScottTargetObjectFile.h"
#include "TargetInfo/ScottTargetInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/LegacyPassManager.h"

using namespace llvm;

class BundleCmpJccPass : public MachineFunctionPass {
public:
  BundleCmpJccPass() : MachineFunctionPass(ID) {}

  StringRef getPassName() const override { return "Bundle CMP with JCC Pass"; }

  bool runOnMachineFunction(MachineFunction &MF) override;
private:
  static char ID;
};

bool BundleCmpJccPass::runOnMachineFunction(MachineFunction &MF)
{
  bool BundledCmp = false;

  for (auto &MBB : MF) {
    // Glueing CMP to JCC (at DAG stage) is not enough to keep them together.
    // They need stronger bonds so that only death can separate them.
    // For some reason spilled reg loads get in the way between them (reg loads require ADD that messes up the flags register).
    //
    // I'll need to look into it as it should not happen (ADD has Defs=[FR]).
    // Probably this happens because the expansion of reg loads happens too late (during TargetFrameIndex elimination?).
    //
    // So bundling them looks like a hack, but seems to work.
    MachineBasicBlock::iterator MBBI = MBB.begin(), E = MBB.end();
    while (MBBI != E) {
      MachineBasicBlock::iterator NMBBI = std::next(MBBI);
      switch (MBBI->getOpcode()) {
      case Scott::CMPrr:
        assert(NMBBI->getOpcode() == Scott::JCC && "JCC should immediately follow CMP");
        NMBBI->bundleWithPred();
        BundledCmp = true;
        break;
      }
      MBBI = NMBBI;
    }
  }
  return BundledCmp;
}

char BundleCmpJccPass::ID = 0;

class InsertClfPass : public MachineFunctionPass {
public:
  InsertClfPass() : MachineFunctionPass(ID) {}

  StringRef getPassName() const override { return "Insert CLF instruction pass"; }

  bool runOnMachineFunction(MachineFunction &MF) override;
private:
  static char ID;
};

bool InsertClfPass::runOnMachineFunction(MachineFunction &MF)
{
  const ScottSubtarget *STI = &MF.getSubtarget<ScottSubtarget>();
  const ScottInstrInfo *TII = STI->getInstrInfo();
  bool InsertedClf = false;

  for (auto &MBB : MF) {
    MachineBasicBlock::iterator MBBI = MBB.begin(), E = MBB.end();
    while (MBBI != E) {
      switch (MBBI->getOpcode()) {
      // Insert CLF before CMP.
      case Scott::CMPrr:
        BuildMI(MBB, MBBI, DebugLoc(), TII->get(Scott::CLF));
        InsertedClf = true;
        break;
      // Insert CLF after ADDrr, SHL, SHR.
      case Scott::ADDrr:
      case Scott::SHL:
      case Scott::SHR:
        BuildMI(MBB, std::next(MBBI), DebugLoc(), TII->get(Scott::CLF));
        InsertedClf = true;
        break;
      }
      MBBI = std::next(MBBI);
    }
  }
  return InsertedClf;
}

char InsertClfPass::ID = 0;

class ExpandSubtractionPass : public MachineFunctionPass {
public:
  ExpandSubtractionPass() : MachineFunctionPass(ID) {}

  StringRef getPassName() const override { return "Expand Subtraction Pass"; }

  bool runOnMachineFunction(MachineFunction &MF) override;
private:
  static char ID;
};

bool ExpandSubtractionPass::runOnMachineFunction(MachineFunction &MF)
{
  const ScottSubtarget *STI = &MF.getSubtarget<ScottSubtarget>();
  const ScottInstrInfo *TII = STI->getInstrInfo();
  DebugLoc DL;
  bool Expanded = false;

  for (auto &MBB : MF) {
    MachineBasicBlock::iterator MBBI = MBB.begin(), E = MBB.end();
    while (MBBI != E) {
      MachineBasicBlock::iterator NMBBI = std::next(MBBI);
      if (MBBI->getOpcode() == Scott::SUB_PSEUDO)
      {
        // TODO: Is there a better place to do this? at DAG time? AsmPrinter?
        const MachineOperand& Minuend = MBBI->getOperand(0);
        const MachineOperand& Subtrahend = MBBI->getOperand(2);

        BuildMI(MBB, MBBI, DL, TII->get(Scott::CPYri)).addReg(Scott::TmpReg).addImm(1);
        BuildMI(MBB, MBBI, DL, TII->get(Scott::NOTrr))
          .addDef(Subtrahend.getReg())
          .addUse(Subtrahend.getReg(), RegState::Kill);
        BuildMI(MBB, MBBI, DL, TII->get(Scott::NO_CLF_ADDrr))
          .addDef(Scott::TmpReg)
          .addUse(Scott::TmpReg, RegState::Kill)
          .addUse(Subtrahend.getReg(), RegState::Kill);
        BuildMI(MBB, MBBI, DL, TII->get(Scott::CLF));
        BuildMI(MBB, MBBI, DL, TII->get(Scott::NO_CLF_ADDrr))
          .addDef(Minuend.getReg())
          .addUse(Minuend.getReg(), RegState::Kill)
          .addUse(Scott::TmpReg, RegState::Kill);
        BuildMI(MBB, MBBI, DL, TII->get(Scott::CLF));

        if (!Subtrahend.isKill())
        {
          BuildMI(MBB, MBBI, DL, TII->get(Scott::NOTrr))
            .addDef(Subtrahend.getReg())
            .addUse(Subtrahend.getReg(), RegState::Kill);
        }

        MBBI->eraseFromParent();
        Expanded = true;
      }
      MBBI = NMBBI;
    }
  }
  return Expanded;
}

char ExpandSubtractionPass::ID = 0;

namespace llvm {

FunctionPass *createBundleCmpJccPass() { return new BundleCmpJccPass(); }
FunctionPass *createInsertClfPass() { return new InsertClfPass(); }
FunctionPass *createExpandSubtractionPass() { return new ExpandSubtractionPass(); }

} // end of namespace llvm
