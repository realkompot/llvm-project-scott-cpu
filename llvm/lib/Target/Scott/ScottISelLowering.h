//===-- ScottISelLowering.h - Scott DAG Lowering Interface ------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that Scott uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_Scott_ScottISELLOWERING_H
#define LLVM_LIB_TARGET_Scott_ScottISELLOWERING_H

#include "Scott.h"
#include "llvm/CodeGen/TargetLowering.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/ISDOpcodes.h"

namespace llvm {
  namespace ScottISD {
    enum NodeType {
      FIRST_NUMBER = ISD::BUILTIN_OP_END,

      // Return with a flag operand. Operand 0 is the chain operand.
      RET_FLAG,

      // The compare instruction
      CMP,

      // Branch conditional, condition-code
      BR_CC,

      // Select the condition code
      SELECT_CC,

      // Wrapper - A wrapper node for TargetGlobalAddress.
      Wrapper,

      /// CALL - These operations represent an abstract call
      /// instruction, which includes a bunch of information.
      CALL,

      // IO Operations
      IO_DATA_IN,
      IO_DATA_OUT,
      IO_ADDRESS_OUT,

      // Clear flags
      CLF,

      // Special instance of ADD that doesn't require CLF after it
      NO_CLF_ADD
    };
  }
}

namespace llvm {
  class ScottSubtarget;
  class ScottRegisterInfo;

  class ScottTargetLowering : public TargetLowering {
    const ScottSubtarget *Subtarget;
  public:
    ScottTargetLowering(const TargetMachine &TM, const ScottSubtarget &STI);

    SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;

    // This method returns the name of a target specific DAG node.
    virtual const char *getTargetNodeName(unsigned Opcode) const override;

    MachineBasicBlock *EmitInstrWithCustomInserter(MachineInstr &MI, MachineBasicBlock *BB) const override;

    SDValue LowerFormalArguments(SDValue Chain, CallingConv::ID CallConv,
                               bool IsVarArg,
                               const SmallVectorImpl<ISD::InputArg> &Ins,
                               const SDLoc &DL, SelectionDAG &DAG,
                               SmallVectorImpl<SDValue> &InVals) const override;

    SDValue LowerCall(TargetLowering::CallLoweringInfo &CLI, SmallVectorImpl<SDValue> &InVals) const override;

    SDValue LowerReturn(SDValue Chain, CallingConv::ID CallConv, bool IsVarArg,
                               const SmallVectorImpl<ISD::OutputArg> &Outs,
                               const SmallVectorImpl<SDValue> &OutVals, const SDLoc &DL,
                               SelectionDAG &DAG) const override;

    bool isSuitableForJumpTable(const SwitchInst *SI, uint64_t NumCases,
                                      uint64_t Range, ProfileSummaryInfo *PSI,
                                      BlockFrequencyInfo *BFI) const override;

  private:
    SDValue LowerBR_CC(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerSELECT_CC(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerGlobalAddress(SDValue Op, SelectionDAG &DAG) const;
    SDValue LowerCallResult(SDValue Chain, SDValue InFlag,
                          CallingConv::ID CallConv, bool isVarArg,
                          const SmallVectorImpl<ISD::InputArg> &Ins,
                          const SDLoc &dl, SelectionDAG &DAG,
                          SmallVectorImpl<SDValue> &InVals) const;

    bool DispatchIoCall(GlobalAddressSDNode *Global, SDValue Chain,
                        const SDLoc &dl,
                        SelectionDAG &DAG,
                        SmallVectorImpl<SDValue> &OutVals,
                        SmallVectorImpl<SDValue> &InVals, SDValue &Result) const;

    const ScottRegisterInfo *TRI;
  };
} // end namespace llvm

#endif    // Scott_ISELLOWERING_H
