//===-- ScottISelDAGToDAG.cpp - A dag to dag inst selector for Scott ------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the Scott target.
//
//===----------------------------------------------------------------------===//

#include "ScottTargetMachine.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;


// Scott-specific code to select Scott machine instructions for
// SelectionDAG operations.
namespace {
class ScottDAGToDAGISel : public SelectionDAGISel {

public:
  explicit ScottDAGToDAGISel(ScottTargetMachine &TM)
      : SelectionDAGISel(TM) {}

  StringRef getPassName() const override {
    return "Scott DAG->DAG Pattern Instruction Selection";
  }

  void Select(SDNode *Node) override;

  bool SelectAddr(SDValue Addr, SDValue &BaseAddr);

  // Include the pieces autogenerated from the target description.
  #include "ScottGenDAGISel.inc"
};
} // end anonymous namespace

void ScottDAGToDAGISel::Select(SDNode *Node) {
  // If we have a custom node, we have already selected
  if (Node->isMachineOpcode()) {
    Node->setNodeId(-1);
    return;
  }

  SDLoc dl(Node);

  switch (Node->getOpcode()) {
    default: break;
    case ISD::FrameIndex: {
      SDValue DummyRegister = CurDAG->getRegister(0, MVT::i16);
      int FI = cast<FrameIndexSDNode>(Node)->getIndex();
      SDValue TFI = CurDAG->getTargetFrameIndex(FI, MVT::i16);

      ReplaceNode(Node, CurDAG->getMachineNode(Scott::NO_CLF_ADDrr, dl, MVT::i16, TFI, DummyRegister));
      return;
    }
  }

  // Select the default instruction.
  SelectCode(Node);
}

/// SelectAddr - returns true if it is able pattern match an addressing mode.
/// It returns the operands which make up the maximal addressing mode it can
/// match by reference.
bool ScottDAGToDAGISel::SelectAddr(SDValue Addr, SDValue &BaseAddr) {
  // Only direct calls.
  if (FrameIndexSDNode *FIN = dyn_cast<FrameIndexSDNode>(Addr)) {
    EVT PtrVT = getTargetLowering()->getPointerTy(CurDAG->getDataLayout());
    BaseAddr = CurDAG->getTargetFrameIndex(FIN->getIndex(), PtrVT);
    return true;
  }

  if (Addr.getOpcode() == ISD::TargetGlobalAddress) {
    return false; // direct calls.
  }

  BaseAddr = Addr;
  return true;
}


/// createScottISelDag - This pass converts a legalized DAG into a
/// Scott-specific DAG, ready for instruction scheduling.
///
FunctionPass *llvm::createScottISelDag(ScottTargetMachine &TM) {
  return new ScottDAGToDAGISel(TM);
}
