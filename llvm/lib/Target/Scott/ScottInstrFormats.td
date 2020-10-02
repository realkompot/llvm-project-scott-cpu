//===-- ScottInstrFormats.td - Scott Instruction Formats ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// Regular 16-bit instruction
class InstScott16<dag outs, dag ins, string asmstr, list<dag> pattern>
    : Instruction {
  field bits<16> Inst;

  let Namespace = "Scott";
  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;
  let Size = 2;
}

// Some instructions like DATA need double space, so let's encode them as 32-bit.
class InstScott32<dag outs, dag ins, string asmstr, list<dag> pattern>
    : Instruction {
  field bits<32> Inst;

  let Namespace = "Scott";
  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;
  let Size = 4;
}

// Pseudo instruction like call/ret
class ScottPseudoInst<dag outs, dag ins, string asmstr, list<dag> pattern>
    : InstScott16<outs, ins, asmstr, pattern> {
  let isPseudo = 1;
  let isCodeGenOnly = 1;
}

// ALU register-register instruction
class InstScottAlu<bits<4> opcode, dag outs, dag ins, string asmstr, list<dag> pattern>
    : InstScott16<outs, ins, asmstr, pattern> {
  bits<2> destReg;
  bits<2> sourceReg;
  let Inst{1-0} = destReg;
  let Inst{3-2} = sourceReg;
  let Inst{7-4} = opcode;
}
