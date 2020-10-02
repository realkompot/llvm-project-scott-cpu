//===-- ScottInstrInfo.td - Target Description for Scott Target -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the Scott instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

include "ScottInstrFormats.td"

//===----------------------------------------------------------------------===//
// Type Profiles.
//===----------------------------------------------------------------------===//

def SDT_ScottCmp          : SDTypeProfile<0, 2, [SDTCisSameAs<0, 1>]>;
def SDT_ScottBrCC         : SDTypeProfile<0, 2, [SDTCisVT<0, OtherVT>, SDTCisVT<1, i16>]>;
def SDT_ScottSelectCC     : SDTypeProfile<1, 3, [SDTCisSameAs<0, 1>, SDTCisSameAs<1, 2>, SDTCisVT<3, i16>]>;
def SDT_ScottWrapper      : SDTypeProfile<1, 1, [SDTCisSameAs<0, 1>, SDTCisPtrTy<0>]>;
def SDT_ScottCall         : SDTypeProfile<0, -1, [SDTCisVT<0, iPTR>]>;
def SDT_ScottCallSeqStart : SDCallSeqStart<[SDTCisVT<0, i16>, SDTCisVT<1, i16>]>;
def SDT_ScottCallSeqEnd   : SDCallSeqEnd<[SDTCisVT<0, i16>, SDTCisVT<1, i16>]>;
def SDT_ScottIoIn         : SDTypeProfile<1, 0, [SDTCisVT<0, i16>]>;
def SDT_ScottIoOut        : SDTypeProfile<0, 1, [SDTCisVT<0, i16>]>;
def SDT_Clf               : SDTypeProfile<0, 0, []>;

//===----------------------------------------------------------------------===//
// Scott Specific Node Definitions.
//===----------------------------------------------------------------------===//

def ScottCallseq_start    : SDNode<"ISD::CALLSEQ_START", SDT_ScottCallSeqStart, [SDNPHasChain, SDNPOutGlue]>;
def ScottCallseq_end      : SDNode<"ISD::CALLSEQ_END",   SDT_ScottCallSeqEnd, [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue]>;
def ScottRetFlag          : SDNode<"ScottISD::RET_FLAG", SDTNone, [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;
def ScottCmp              : SDNode<"ScottISD::CMP", SDT_ScottCmp, [SDNPOutGlue, SDNPInGlue]>;
def ScottBrcc             : SDNode<"ScottISD::BR_CC", SDT_ScottBrCC, [SDNPHasChain, SDNPInGlue]>;
def ScottSelectCC         : SDNode<"ScottISD::SELECT_CC", SDT_ScottSelectCC, [SDNPInGlue]>;
def ScottWrapper          : SDNode<"ScottISD::Wrapper", SDT_ScottWrapper>;
def ScottCall             : SDNode<"ScottISD::CALL", SDT_ScottCall, [SDNPHasChain, SDNPOutGlue, SDNPOptInGlue, SDNPVariadic]>;
def ScottIoDataIn         : SDNode<"ScottISD::IO_DATA_IN", SDT_ScottIoIn, [SDNPHasChain]>;
def ScottIoDataOut        : SDNode<"ScottISD::IO_DATA_OUT", SDT_ScottIoOut, [SDNPHasChain]>;
def ScottIoAddressOut     : SDNode<"ScottISD::IO_ADDRESS_OUT", SDT_ScottIoOut, [SDNPHasChain]>;
def ScottClf              : SDNode<"ScottISD::CLF", SDT_Clf, [SDNPOutGlue]>;
def ScottNoClfAdd         : SDNode<"ScottISD::NO_CLF_ADD", SDTIntBinOp, [SDNPCommutative, SDNPAssociative]>;

//===----------------------------------------------------------------------===//
// Scott Operand Definitions.
//===----------------------------------------------------------------------===//

// Immediate/Constant operand
def Immediate16 : Operand<i16>, ImmLeaf<i16, [{
  return Imm >= -32768 && Imm < 32768;
}]>;

def JmpTarget : Operand<OtherVT> {
}

// Operand for printing out a condition code.
def ConditionCode : Operand<i16> {
  let PrintMethod = "printCCOperand";
}

//===----------------------------------------------------------------------===//
// Scott Complex Pattern Definitions.
//===----------------------------------------------------------------------===//

def addr : ComplexPattern<iPTR, 1, "SelectAddr", [], []>;

//===----------------------------------------------------------------------===//
// ALU Instructions
//===----------------------------------------------------------------------===//

let Defs = [FR], isCommutable = 1, Constraints = "$sourceReg2 = $destReg" in {
  multiclass ALU<bits<4> opcode, string opstr, SDNode opnode> {
    def rr : InstScottAlu<opcode,
                     (outs GPRegs:$destReg), (ins GPRegs:$sourceReg2, GPRegs:$sourceReg),
                     !strconcat(opstr, "\t$sourceReg, $destReg"),
                     [(set GPRegs:$destReg, (opnode GPRegs:$sourceReg2, GPRegs:$sourceReg)),
                     (implicit FR)]> {
    }
  }

  defm ADD        : ALU<0b1000, "ADD", add>;
  defm NO_CLF_ADD : ALU<0b1000, "ADD", ScottNoClfAdd>;
  defm AND        : ALU<0b1100, "AND", and>;
  defm OR         : ALU<0b1101, "OR",  or>;
  defm XOR        : ALU<0b1110, "XOR", xor>;

  def NOTrr : InstScott16<(outs GPRegs:$destReg), (ins GPRegs:$sourceReg2), "NOT\t$sourceReg2", [(set GPRegs:$destReg, (not GPRegs:$sourceReg2)), (implicit FR)]> {
    bits<2> destReg;
    bits<2> sourceReg2;
    let Inst{1-0} = destReg;
    let Inst{3-2} = sourceReg2;
    let Inst{7-4} = 0b1011;
  }
}

//===----------------------------------------------------------------------===//
// Shift Instructions
//===----------------------------------------------------------------------===//

let Defs = [FR], Constraints = "$sourceReg = $destReg" in {
  def SHL : InstScott16<(outs GPRegs:$destReg), (ins GPRegs:$sourceReg), "SHL\t$destReg", [(set GPRegs:$destReg, (shl GPRegs:$sourceReg, 1)), (implicit FR)]> {
    bits<2> destReg;
    bits<2> sourceReg;
    let Inst{1-0} = destReg;
    let Inst{3-2} = sourceReg;
    let Inst{7-4} = 0b1010;
  }

  def SHR : InstScott16<(outs GPRegs:$destReg), (ins GPRegs:$sourceReg), "SHR\t$destReg", [(set GPRegs:$destReg, (srl GPRegs:$sourceReg, 1)), (implicit FR)]> {
    bits<2> destReg;
    bits<2> sourceReg;
    let Inst{1-0} = destReg;
    let Inst{3-2} = sourceReg;
    let Inst{7-4} = 0b1001;
  }
}

//===----------------------------------------------------------------------===//
// Data Transfer Instructions
//===----------------------------------------------------------------------===//

let isAsCheapAsAMove = 1 in {
  def CPYri  : InstScott32<(outs GPRegs:$destReg), (ins Immediate16:$const),
                      "DATA\t$destReg, $const",
                      [(set GPRegs:$destReg, Immediate16:$const)]> {
    bits<2> destReg;
    bits<16> const;
    let Inst{5} = 0b1;
    let Inst{1-0} = destReg;
    let Inst{31-16} = const;
  }
} // isAsCheapAsAMove = 1


//===----------------------------------------------------------------------===//
// Comparison Instructions
//===----------------------------------------------------------------------===//

let Defs = [FR] in {
  def CMPrr : InstScott16<(outs), (ins GPRegs:$reg1, GPRegs:$reg2), "CMP\t$reg1, $reg2", [(ScottCmp GPRegs:$reg1, GPRegs:$reg2), (implicit FR)]> {
    bits<2> reg1;
    bits<2> reg2;
    let Inst{1-0} = reg2;
    let Inst{3-2} = reg1;
    let Inst{7-4} = 0b1111;
  }
}

let hasSideEffects = 1, Defs = [FR] in {
  def CLF : InstScott16<(outs), (ins), "CLF", [(ScottClf), (implicit FR)]> {
    let Inst{6-5} = 0b11;
  }
}

//===----------------------------------------------------------------------===//
// Load/Store Instructions
//===----------------------------------------------------------------------===//

def LD : InstScott16<(outs GPRegs:$destReg), (ins GPRegs:$addr), "LOAD\t$addr, $destReg", [(set GPRegs:$destReg, (load addr:$addr))]> {
  bits<2> destReg;
  bits<16> addr;
  let Inst{3-2} = addr{1-0};
  let Inst{1-0} = destReg;
}

def ST : InstScott16<(outs), (ins GPRegs:$regToStore, GPRegs:$addr), "STORE\t$addr, $regToStore", [(store GPRegs:$regToStore, addr:$addr)]> {
  bits<2> regToStore;
  bits<16> addr;
  let Inst{4} = 0b1;
  let Inst{3-2} = addr{1-0};
  let Inst{1-0} = regToStore;
}

//===----------------------------------------------------------------------===//
// Jump (branch) Instructions
//===----------------------------------------------------------------------===//

// Unconditional jump
let isBranch = 1, isTerminator = 1, isBarrier = 1 in {
  def JMP : InstScott32<(outs), (ins JmpTarget:$addr), "JMP\t$addr", [(br bb:$addr)]> {
    bits<16> addr;
    let Inst{6} = 0b1;
    let Inst{31-16} = addr;
  }

  let isIndirectBranch = 1 in {
    def JMPrr : InstScott16<(outs), (ins GPRegs:$targetReg), "JMPR\t$targetReg", [(brind GPRegs:$targetReg)]> {
      bits<2> targetReg;
      let Inst{5-4} = 0b11;
      let Inst{1-0} = targetReg;
    }
  }
}

// Conditional jump
let isBranch = 1, isTerminator = 1, Uses=[FR] in {
  def JCC : InstScott32<(outs), (ins JmpTarget:$addr, ConditionCode:$condition),
                        "J$condition\t$addr", [(ScottBrcc bb:$addr, imm:$condition)]> {
    bits<16> addr;
    bits<4> condition;

    let Inst{3-0} = condition;
    let Inst{6-4} = 0b101;
    let Inst{31-16} = addr;
  }
}

//===----------------------------------------------------------------------===//
// Pseudo Instructions
//===----------------------------------------------------------------------===//

let Defs = [SP], Uses = [SP] in {
  def ADJCALLSTACKDOWN : ScottPseudoInst<(outs), (ins Immediate16:$amt, Immediate16:$amt2),
                                       "#ADJCALLSTACKDOWN",
                                       [(ScottCallseq_start timm:$amt, timm:$amt2)]>;
  def ADJCALLSTACKUP : ScottPseudoInst<(outs), (ins Immediate16:$amt1, Immediate16:$amt2),
                                     "#ADJCALLSTACKUP",
                                     [(ScottCallseq_end timm:$amt1, timm:$amt2)]>;
}

let Uses = [SP], Defs = [R1], isCall = 1 in {
  def CALL_PSEUDO : ScottPseudoInst<(outs), (ins Immediate16:$addr),
                      "# call\t$addr", [(ScottCall imm:$addr)]> {
  }
}

let Uses = [SP], isTerminator = 1, isReturn = 1, isBarrier = 1 in {
  def RET_PSEUDO : ScottPseudoInst<(outs), (ins),
                    "# ret",  [(ScottRetFlag)]> {
  }
}

let Constraints = "$sourceReg2 = $destReg", Defs = [FR] in {
  def SUB_PSEUDO : ScottPseudoInst<(outs GPRegs:$destReg), (ins GPRegs:$sourceReg2, GPRegs:$sourceReg),
                   "# SUB\t$sourceReg, $destReg",
                   [(set GPRegs:$destReg, (sub GPRegs:$sourceReg2, GPRegs:$sourceReg)), (implicit FR)]> {
  }
}

//===----------------------------------------------------------------------===//
// I/O Instructions
//===----------------------------------------------------------------------===//

let hasSideEffects = 1 in {
  def IO_DATA_IN : InstScott16<(outs GPRegs:$destReg), (ins), "IN\tData, $destReg", [(set GPRegs:$destReg, ScottIoDataIn)]> {
    bits<2> destReg;
    let Inst{6-4} = 0b111;
    let Inst{1-0} = destReg;
  }

  def IO_DATA_OUT : InstScott16<(outs), (ins GPRegs:$regToOut), "OUT\tData, $regToOut", [(ScottIoDataOut GPRegs:$regToOut)]> {
    bits<2> regToOut;
    let Inst{6-3} = 0b1111;
    let Inst{1-0} = regToOut;
  }

  def IO_ADDRESS_OUT : InstScott16<(outs), (ins GPRegs:$regToOut), "OUT\tAddr, $regToOut", [(ScottIoAddressOut GPRegs:$regToOut)]> {
    bits<2> regToOut;
    let Inst{6-2} = 0b11111;
    let Inst{1-0} = regToOut;
  }
}

//===----------------------------------------------------------------------===//
// Non-Instruction Patterns
//===----------------------------------------------------------------------===//
let usesCustomInserter = 1 in
def Select : ScottPseudoInst<(outs GPRegs:$dst),
                    (ins GPRegs:$src, GPRegs:$src2, i16imm:$condition),
                    "# Select PSEUDO",
                    [(set GPRegs:$dst,
                     (ScottSelectCC GPRegs:$src, GPRegs:$src2, imm:$condition))]>;

// GlobalAddress
def : Pat<(i16 (ScottWrapper tglobaladdr:$dst)), (CPYri tglobaladdr:$dst)>;

// Calls
def : Pat<(ScottCall (i16 tglobaladdr:$addr)), (CALL_PSEUDO tglobaladdr:$addr)>;
