//===-- ScottISelLowering.cpp - Scott DAG Lowering Implementation ---------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the interfaces that Scott uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#include "ScottISelLowering.h"
#include "ScottMachineFunctionInfo.h"
#include "ScottRegisterInfo.h"
#include "ScottTargetMachine.h"
#include "ScottTargetObjectFile.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/CodeGen/CallingConvLower.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"
using namespace llvm;

#include "ScottGenCallingConv.inc"

const char *ScottTargetLowering::getTargetNodeName(unsigned Opcode) const {
  switch ((ScottISD::NodeType)Opcode) {
    case ScottISD::FIRST_NUMBER:            break;
    case ScottISD::CMP:                     return "ScottISD::CMP";
    case ScottISD::RET_FLAG:                return "ScottISD::RET_FLAG";
    case ScottISD::BR_CC:                   return "ScottISD::BR_CC";
    case ScottISD::SELECT_CC:               return "ScottISD::SELECT_CC";
    case ScottISD::Wrapper:                 return "ScottISD::Wrapper";
    case ScottISD::CALL:                    return "ScottISD::CALL";
    case ScottISD::IO_DATA_IN:              return "ScottISD::IO_DATA_IN";
    case ScottISD::IO_DATA_OUT:             return "ScottISD::IO_DATA_OUT";
    case ScottISD::IO_ADDRESS_OUT:          return "ScottISD::IO_ADDRESS_OUT";
    case ScottISD::CLF:                     return "ScottISD::CLF";
    case ScottISD::NO_CLF_ADD:              return "ScottISD::NO_CLF_ADD";
  }
  return nullptr;
}

ScottTargetLowering::ScottTargetLowering(const TargetMachine &TM, const ScottSubtarget &STI) : TargetLowering(TM) {
  // Set up the register classes.
  addRegisterClass(MVT::i16, &Scott::GPRegsRegClass);

  // Compute derived properties from the register classes
  TRI = STI.getRegisterInfo();
  computeRegisterProperties(TRI);

  setStackPointerRegisterToSaveRestore(Scott::SP);
  setBooleanContents(ZeroOrOneBooleanContent);

  setOperationAction(ISD::BR_JT,            MVT::Other,   Expand);
  setOperationAction(ISD::BR_CC,            MVT::i16,     Custom);
  setOperationAction(ISD::BRCOND,           MVT::Other,   Expand);
  setOperationAction(ISD::SELECT,           MVT::i16,     Expand);
  setOperationAction(ISD::SELECT_CC,        MVT::i16,     Custom);
  setOperationAction(ISD::GlobalAddress,    MVT::i16,     Custom);
  setOperationAction(ISD::ExternalSymbol,   MVT::i16,     Custom);
  setOperationAction(ISD::SETCC,            MVT::i16,     Expand);

  setOperationAction(ISD::SIGN_EXTEND_INREG, MVT::i1, Expand);
  setOperationAction(ISD::SIGN_EXTEND_INREG, MVT::i8, Expand);

  setLoadExtAction(ISD::EXTLOAD, MVT::i16, MVT::i8, Expand);
  setLoadExtAction(ISD::ZEXTLOAD, MVT::i16, MVT::i8, Expand);
}

SDValue ScottTargetLowering::LowerOperation(SDValue Op, SelectionDAG &DAG) const {
  switch (Op.getOpcode()) {
    case ISD::BR_CC:            return LowerBR_CC(Op, DAG);
    case ISD::SELECT_CC:        return LowerSELECT_CC(Op, DAG);
    case ISD::GlobalAddress:    return LowerGlobalAddress(Op, DAG);
    default:
      llvm_unreachable("unimplemented operation");
  }
}

// Transform physical registers into virtual registers
SDValue ScottTargetLowering::LowerFormalArguments(
    SDValue Chain, CallingConv::ID CallConv, bool IsVarArg,
    const SmallVectorImpl<ISD::InputArg> &Ins, const SDLoc &DL,
    SelectionDAG &DAG, SmallVectorImpl<SDValue> &InVals) const {

  if (CallConv != CallingConv::C) {
    llvm_unreachable("Unsupported calling convention");
  }

  if (IsVarArg) {
    llvm_unreachable("VarArg not supported");
  }

  MachineFunction &MF = DAG.getMachineFunction();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  MachineRegisterInfo &RegInfo = MF.getRegInfo();

  // Assign locations to all of the incoming arguments.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CallConv, IsVarArg, MF, ArgLocs, *DAG.getContext());
  CCInfo.AnalyzeFormalArguments(Ins, CC_Scott);

  for (auto &VA : ArgLocs) {
    if (VA.isRegLoc()) {
      // Arguments passed in registers
      EVT RegVT = VA.getLocVT();
      switch (RegVT.getSimpleVT().SimpleTy) {
      case MVT::i16: {
        const unsigned VReg = RegInfo.createVirtualRegister(&Scott::GPRegsRegClass);
        RegInfo.addLiveIn(VA.getLocReg(), VReg);
        SDValue ArgIn = DAG.getCopyFromReg(Chain, DL, VReg, RegVT);

        InVals.push_back(ArgIn);
        break;
      }
      default:
        llvm_unreachable("unhandled argument type");
      }
    } else {
      // Sanity check
      assert(VA.isMemLoc());
      // Load the argument to a virtual register
      unsigned ObjSize = VA.getLocVT().getSizeInBits() / BYTE_SIZE;
      // Check that the argument fits in stack slot
      if (ObjSize > 1) {
        errs() << "LowerFormalArguments Unhandled argument type: "
               << EVT(VA.getLocVT()).getEVTString() << "\n";
      }
      // Create the frame index object for this incoming parameter...
      int FI = MFI.CreateFixedObject(ObjSize, VA.getLocMemOffset(), true);

      // Create the SelectionDAG nodes corresponding to a load
      // from this parameter
      SDValue FIN = DAG.getFrameIndex(FI, MVT::i16);
      InVals.push_back(DAG.getLoad(
          VA.getLocVT(), DL, Chain, FIN,
          MachinePointerInfo::getFixedStack(DAG.getMachineFunction(), FI))); ;
    }
  }
  return Chain;
}

SDValue ScottTargetLowering::LowerReturn(SDValue Chain, CallingConv::ID CallConv,
                               bool IsVarArg,
                               const SmallVectorImpl<ISD::OutputArg> &Outs,
                               const SmallVectorImpl<SDValue> &OutVals,
                               const SDLoc &DL, SelectionDAG &DAG) const {
  if (IsVarArg) {
    report_fatal_error("VarArg not supported");
  }

  // Stores the assignment of the return value to a location
  SmallVector<CCValAssign, 16> RVLocs;

  // Info about the registers and stack slot
  CCState CCInfo(CallConv, IsVarArg, DAG.getMachineFunction(), RVLocs,
                 *DAG.getContext());

  CCInfo.AnalyzeReturn(Outs, RetCC_Scott);

  SDValue Flag;
  SmallVector<SDValue, 4> RetOps(1, Chain);

  // Copy the result values into the output registers.
  for (unsigned i = 0, e = RVLocs.size(); i < e; ++i) {
    CCValAssign &VA = RVLocs[i];
    assert(VA.isRegLoc() && "Can only return in registers!");

    Chain = DAG.getCopyToReg(Chain, DL, VA.getLocReg(), OutVals[i], Flag);

    // Guarantee that all emitted copies are stuck together
    Flag = Chain.getValue(1);
    RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
  }

  RetOps[0] = Chain; // Update chain.

  // Add the flag if we have it.
  if (Flag.getNode()) {
    RetOps.push_back(Flag);
  }

  return DAG.getNode(ScottISD::RET_FLAG, DL, MVT::Other, RetOps);
}

static SDValue EmitCMP(SDValue &LHS, SDValue &RHS, SDValue &TargetCC,
                       ISD::CondCode CC, const SDLoc &dl, SelectionDAG &DAG) {
  assert(!LHS.getValueType().isFloatingPoint() && "Floating point types are not supported.");

  ScottCC::CondCodes TCC = ScottCC::COND_INVALID;
  switch (CC) {
    default: llvm_unreachable("Invalid integer condition.");
    case ISD::SETEQ:
      TCC = ScottCC::COND_E;
      break;
    case ISD::SETULE:
    case ISD::SETLE:
      TCC = ScottCC::COND_AE;
      std::swap(LHS, RHS);
      break;
    case ISD::SETUGE:
    case ISD::SETGE:
      TCC = ScottCC::COND_AE;
      break;
    case ISD::SETUGT:
    case ISD::SETGT:
      TCC = ScottCC::COND_A;
      break;
    case ISD::SETULT:
    case ISD::SETLT:
      TCC = ScottCC::COND_A;
      std::swap(LHS, RHS);
      break;
  }

  TargetCC = DAG.getConstant(TCC, dl, MVT::i16);

  return DAG.getNode(ScottISD::CMP, dl, MVT::Glue, LHS, RHS);
}

SDValue ScottTargetLowering::LowerBR_CC(SDValue Op, SelectionDAG &DAG) const {
  SDValue Chain = Op.getOperand(0);
  ISD::CondCode CC = cast<CondCodeSDNode>(Op.getOperand(1))->get();
  SDValue LHS   = Op.getOperand(2);
  SDValue RHS   = Op.getOperand(3);
  SDValue Dest  = Op.getOperand(4);
  SDLoc dl  (Op);
  SDValue TargetCC;
  SDValue Flag;

  // The cpu doesn't have a flag for 'not equal' so resorting to XOR
  if (CC == ISD::SETNE)
  {
    LHS = DAG.getNode(ISD::XOR, dl, MVT::i16, LHS, RHS);
    RHS = DAG.getConstant(0, dl, MVT::i16);
    CC = ISD::SETUGT;
  }

  Flag = EmitCMP(LHS, RHS, TargetCC, CC, dl, DAG);

  return DAG.getNode(ScottISD::BR_CC, dl, Op.getValueType(),
                     Chain, Dest, TargetCC, Flag);
}

SDValue ScottTargetLowering::LowerSELECT_CC(SDValue Op,
                                             SelectionDAG &DAG) const {
  SDValue LHS    = Op.getOperand(0);
  SDValue RHS    = Op.getOperand(1);
  SDValue TrueV  = Op.getOperand(2);
  SDValue FalseV = Op.getOperand(3);
  ISD::CondCode CC = cast<CondCodeSDNode>(Op.getOperand(4))->get();
  SDLoc dl   (Op);
  SDValue TargetCC;

  // In case of 'not equal' change it to 'equal' and swap targets.
  if (CC == ISD::SETNE)
  {
    CC = ISD::SETEQ;
    std::swap(TrueV, FalseV);
  }

  SDValue Flag = EmitCMP(LHS, RHS, TargetCC, CC, dl, DAG);
  SDVTList VTs = DAG.getVTList(Op.getValueType(), MVT::Glue);
  SDValue Ops[] = {TrueV, FalseV, TargetCC, Flag};

  return DAG.getNode(ScottISD::SELECT_CC, dl, VTs, Ops);
}

SDValue ScottTargetLowering::LowerGlobalAddress(SDValue Op,
                                              SelectionDAG &DAG) const {
  const GlobalValue *GV = cast<GlobalAddressSDNode>(Op)->getGlobal();
  int64_t Offset = cast<GlobalAddressSDNode>(Op)->getOffset();
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  // Create the TargetGlobalAddress node, folding in the constant offset.
  SDValue Result = DAG.getTargetGlobalAddress(GV, SDLoc(Op), PtrVT, Offset);
  return DAG.getNode(ScottISD::Wrapper, SDLoc(Op), PtrVT, Result);
}

MachineBasicBlock *ScottTargetLowering::EmitInstrWithCustomInserter(MachineInstr &MI,
                                               MachineBasicBlock *BB) const {
  unsigned Opc = MI.getOpcode();

  const TargetInstrInfo &TII = *BB->getParent()->getSubtarget().getInstrInfo();
  DebugLoc dl = MI.getDebugLoc();

  assert(Opc == Scott::Select && "Unexpected instr type to insert");

  // To "insert" a SELECT instruction, we actually have to insert the diamond
  // control-flow pattern.  The incoming instruction knows the destination vreg
  // to set, the condition code register to branch on, the true/false values to
  // select between, and a branch opcode to use.
  const BasicBlock *LLVM_BB = BB->getBasicBlock();
  MachineFunction::iterator I = ++BB->getIterator();

  //  thisMBB:
  //  ...
  //   TrueVal = ...
  //   cmpTY ccX, r1, r2
  //   jCC copy1MBB
  //   fallthrough --> copy0MBB
  MachineBasicBlock *thisMBB = BB;
  MachineFunction *F = BB->getParent();
  MachineBasicBlock *copy0MBB = F->CreateMachineBasicBlock(LLVM_BB);
  MachineBasicBlock *copy1MBB = F->CreateMachineBasicBlock(LLVM_BB);
  F->insert(I, copy0MBB);
  F->insert(I, copy1MBB);
  // Update machine-CFG edges by transferring all successors of the current
  // block to the new block which will contain the Phi node for the select.
  copy1MBB->splice(copy1MBB->begin(), BB,
                   std::next(MachineBasicBlock::iterator(MI)), BB->end());
  copy1MBB->transferSuccessorsAndUpdatePHIs(BB);
  // Next, add the true and fallthrough blocks as its successors.
  BB->addSuccessor(copy0MBB);
  BB->addSuccessor(copy1MBB);

  BuildMI(BB, dl, TII.get(Scott::JCC))
      .addMBB(copy1MBB)
      .addImm(MI.getOperand(3).getImm());

  //  copy0MBB:
  //   %FalseValue = ...
  //   # fallthrough to copy1MBB
  BB = copy0MBB;

  // Update machine-CFG edges
  BB->addSuccessor(copy1MBB);

  //  copy1MBB:
  //   %Result = phi [ %FalseValue, copy0MBB ], [ %TrueValue, thisMBB ]
  //  ...
  BB = copy1MBB;
  BuildMI(*BB, BB->begin(), dl, TII.get(Scott::PHI), MI.getOperand(0).getReg())
      .addReg(MI.getOperand(2).getReg())
      .addMBB(copy0MBB)
      .addReg(MI.getOperand(1).getReg())
      .addMBB(thisMBB);

  MI.eraseFromParent(); // The pseudo instruction is gone now.
  return BB;
}

SDValue ScottTargetLowering::LowerCall(TargetLowering::CallLoweringInfo &CLI, SmallVectorImpl<SDValue> &InVals) const {
  SelectionDAG &DAG                     = CLI.DAG;
  SDLoc &dl                             = CLI.DL;
  SmallVectorImpl<ISD::OutputArg> &Outs = CLI.Outs;
  SmallVectorImpl<SDValue> &OutVals     = CLI.OutVals;
  SmallVectorImpl<ISD::InputArg> &Ins   = CLI.Ins;
  SDValue Chain                         = CLI.Chain;
  SDValue Callee                        = CLI.Callee;
  bool &isTailCall                      = CLI.IsTailCall;
  CallingConv::ID CallConv              = CLI.CallConv;
  bool isVarArg                         = CLI.IsVarArg;

  // Scott target does not yet support tail call optimization.
  isTailCall = false;

  // If the callee is a GlobalAddress node (quite common, every direct call is)
  // turn it into a TargetGlobalAddress node so that legalize doesn't hack it.
  if (GlobalAddressSDNode *G = dyn_cast<GlobalAddressSDNode>(Callee))
  {
    SDValue IoCall;
    if (DispatchIoCall(G, Chain, dl, DAG, OutVals, InVals, IoCall))
      return IoCall;

    Callee = DAG.getTargetGlobalAddress(G->getGlobal(), dl, MVT::i16);
  }
  else if (isa<ExternalSymbolSDNode>(Callee))
    llvm_unreachable("External symbols are not supported.");

  // Analyze operands of the call, assigning locations to each operand.
  SmallVector<CCValAssign, 16> ArgLocs;
  CCState CCInfo(CallConv, isVarArg, DAG.getMachineFunction(), ArgLocs,
                 *DAG.getContext());

  CCInfo.AnalyzeCallOperands(Outs, CC_Scott);

  // Get a count of how many bytes are to be pushed on the stack.
  unsigned NumBytes = CCInfo.getNextStackOffset();
  auto PtrVT = getPointerTy(DAG.getDataLayout());

  Chain = DAG.getCALLSEQ_START(Chain, NumBytes, 0, dl);

  // Create local copies for byval args.
  MachineFrameInfo &MFI = DAG.getMachineFunction().getFrameInfo();
  SmallVector<SDValue, 8> ByValArgs;
  for (unsigned I = 0, E = Outs.size(); I != E; ++I) {
    ISD::ArgFlagsTy Flags = Outs[I].Flags;
    if (!Flags.isByVal())
      continue;

    SDValue Arg = OutVals[I];
    unsigned Size = Flags.getByValSize();
    Align Alignment = Flags.getNonZeroByValAlign();

    int FI = MFI.CreateStackObject(Size, Alignment, false);
    SDValue FIPtr = DAG.getFrameIndex(FI, getPointerTy(DAG.getDataLayout()));
    SDValue SizeNode = DAG.getConstant(Size, dl, MVT::i16);

    Chain = DAG.getMemcpy(Chain, dl, FIPtr, Arg, SizeNode, Alignment,
                          /*IsVolatile=*/false,
                          /*AlwaysInline=*/false,
                          /*isTailCall=*/false, MachinePointerInfo(),
                          MachinePointerInfo());
    ByValArgs.push_back(FIPtr);
  }


  SmallVector<std::pair<unsigned, SDValue>, 4> RegsToPass;
  SmallVector<SDValue, 12> MemOpChains;
  SDValue StackPtr;

  // Walk the register/memloc assignments, inserting copies/loads.
  for (unsigned i = 0, j = 0, e = ArgLocs.size(); i != e; ++i) {
    CCValAssign &VA = ArgLocs[i];
    ISD::ArgFlagsTy Flags = Outs[i].Flags;
    SDValue Arg = OutVals[i];

    if (VA.getLocInfo() != CCValAssign::Full)
      llvm_unreachable("Unknown loc info!");

    // Use local copy if it is a byval arg.
    if (Flags.isByVal())
      Arg = ByValArgs[j++];

    // Arguments that can be passed on register must be kept at RegsToPass
    // vector
    if (VA.isRegLoc()) {
      RegsToPass.push_back(std::make_pair(VA.getLocReg(), Arg));
    } else {
      assert(VA.isMemLoc());

      if (!StackPtr.getNode())
        StackPtr = DAG.getCopyFromReg(Chain, dl, Scott::SP, PtrVT);

      SDValue PtrOff =
          DAG.getNode(ISD::ADD, dl, PtrVT, StackPtr,
                      DAG.getIntPtrConstant(VA.getLocMemOffset() + ScottMachineFunctionInfo::ExtraSpaceForReturnAddress, dl));

      MemOpChains.push_back(
        DAG.getStore(Chain, dl, Arg, PtrOff, MachinePointerInfo()));
    }
  }

  // Transform all store nodes into one single node because all store nodes are
  // independent of each other.
  if (!MemOpChains.empty())
    Chain = DAG.getNode(ISD::TokenFactor, dl, MVT::Other, MemOpChains);

  // Build a sequence of copy-to-reg nodes chained together with token chain and
  // flag operands which copy the outgoing args into registers.  The InFlag in
  // necessary since all emitted instructions must be stuck together.
  SDValue InFlag;
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i) {
    Chain = DAG.getCopyToReg(Chain, dl, RegsToPass[i].first,
                             RegsToPass[i].second, InFlag);
    InFlag = Chain.getValue(1);
  }

  // Returns a chain & a flag for retval copy to use.
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  SmallVector<SDValue, 8> Ops;
  Ops.push_back(Chain);
  Ops.push_back(Callee);

  // Add a register mask operand representing the call-preserved registers.
  const uint32_t *Mask = TRI->getCallPreservedMask(DAG.getMachineFunction(), CallConv);
  assert(Mask && "Missing call preserved mask for calling convention");
  Ops.push_back(DAG.getRegisterMask(Mask));

  // Add argument registers to the end of the list so that they are
  // known live into the call.
  for (unsigned i = 0, e = RegsToPass.size(); i != e; ++i)
    Ops.push_back(DAG.getRegister(RegsToPass[i].first,
                                  RegsToPass[i].second.getValueType()));

  if (InFlag.getNode())
    Ops.push_back(InFlag);

  Chain = DAG.getNode(ScottISD::CALL, dl, NodeTys, Ops);
  InFlag = Chain.getValue(1);

  // Handle result values, copying them out of physregs into vregs that we
  // return.
  return LowerCallResult(Chain, InFlag, CallConv, isVarArg, Ins, dl,
                         DAG, InVals);
}

/// LowerCallResult - Lower the result values of a call into the
/// appropriate copies out of appropriate physical registers.
///
SDValue ScottTargetLowering::LowerCallResult(
    SDValue Chain, SDValue InFlag, CallingConv::ID CallConv, bool isVarArg,
    const SmallVectorImpl<ISD::InputArg> &Ins, const SDLoc &dl,
    SelectionDAG &DAG, SmallVectorImpl<SDValue> &InVals) const {

  // Assign locations to each value returned by this call.
  SmallVector<CCValAssign, 16> RVLocs;
  CCState CCInfo(CallConv, isVarArg, DAG.getMachineFunction(), RVLocs, *DAG.getContext());
  CCInfo.AnalyzeCallResult(Ins, RetCC_Scott);

  for (unsigned i = 0; i != RVLocs.size(); ++i) {
    Chain = DAG.getCopyFromReg(Chain, dl, RVLocs[i].getLocReg(), RVLocs[i].getValVT(), InFlag).getValue(1);
    InFlag = Chain.getValue(2);
    InVals.push_back(Chain.getValue(0));
  }

  return Chain;
}

SDValue LowerIoInCall(SDValue Chain, const SDLoc &dl, SelectionDAG &DAG, SmallVectorImpl<SDValue> &OutVals, SmallVectorImpl<SDValue> &InVals)
{
  if (OutVals.size())
    llvm_unreachable("io_data_in can't have arguments");

  SDVTList NodeTys = DAG.getVTList(MVT::i16, MVT::Other);
  SmallVector<SDValue, 1> Ops;
  Ops.push_back(Chain);
  Chain = DAG.getNode(ScottISD::IO_DATA_IN, dl, NodeTys, Ops);
  InVals.push_back(Chain.getValue(0));

  return Chain.getValue(1);
}

SDValue LowerIoDataOutCall(SDValue Chain, const SDLoc &dl, SelectionDAG &DAG, SmallVectorImpl<SDValue> &OutVals, SmallVectorImpl<SDValue> &InVals)
{
  if (OutVals.size() != 1)
    llvm_unreachable("io_data_out takes exactly 1 argument");

  SDVTList NodeTys = DAG.getVTList(MVT::Other);
  SmallVector<SDValue, 2> Ops;
  Ops.push_back(Chain);
  Ops.push_back(OutVals.front());
  Chain = DAG.getNode(ScottISD::IO_DATA_OUT, dl, NodeTys, Ops);

  return Chain;
}

SDValue LowerIoAddressOutCall(SDValue Chain, const SDLoc &dl, SelectionDAG &DAG, SmallVectorImpl<SDValue> &OutVals, SmallVectorImpl<SDValue> &InVals)
{
  if (OutVals.size() != 1)
    llvm_unreachable("io_address_out takes exactly 1 argument");

  SDVTList NodeTys = DAG.getVTList(MVT::Other);
  SmallVector<SDValue, 2> Ops;
  Ops.push_back(Chain);
  Ops.push_back(OutVals.front());
  Chain = DAG.getNode(ScottISD::IO_ADDRESS_OUT, dl, NodeTys, Ops);

  return Chain;
}

bool ScottTargetLowering::DispatchIoCall(GlobalAddressSDNode *Global, SDValue Chain, const SDLoc &dl, SelectionDAG &DAG, SmallVectorImpl<SDValue> &OutVals, SmallVectorImpl<SDValue> &InVals, SDValue &Result) const
{
  typedef SDValue (Handler)(SDValue, const SDLoc&, SelectionDAG&, SmallVectorImpl<SDValue>&, SmallVectorImpl<SDValue>&);

  StringRef Name = Global->getGlobal()->getName();
  Handler *H = StringSwitch<Handler*>(Name)
    .Case("io_data_in", &LowerIoInCall)
    .Case("io_data_out", &LowerIoDataOutCall)
    .Case("io_address_out", &LowerIoAddressOutCall)
    .Default(nullptr);

  if (H) {
    Result = H(Chain, dl, DAG, OutVals, InVals);
    return true;
  }

  return false;
}

bool ScottTargetLowering::isSuitableForJumpTable(const SwitchInst *SI, uint64_t NumCases,
                                      uint64_t Range, ProfileSummaryInfo *PSI,
                                      BlockFrequencyInfo *BFI) const {
  return false;
}
