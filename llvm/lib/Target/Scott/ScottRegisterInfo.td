//===-- ScottRegisterInfo.td - Scott Register defs ---------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the Scott register file
//===----------------------------------------------------------------------===//

// General register definition
class ScottReg<bits<16> Enc, string n> : Register<n> {
  let Namespace = "Scott";
  let HWEncoding = Enc;
}

// General purpose registers
def R0 : ScottReg<0, "R0">;
def R1 : ScottReg<1, "R1">;

// Special purpose registers
def TmpReg : ScottReg<2, "R2">; // R2 will serve as the temp register.
def SP : ScottReg<3, "R3">; // R3 will serve as the stack register.
def FR : ScottReg<4, "FR">; // Flags (isn't encoded by any instr)
def PC : ScottReg<5, "PC">; // Program counter (isn't encoded by any instr)

def FlagReg : RegisterClass<"Scott", [i16], 16, (add FR)>;
def ProgramCounterReg : RegisterClass<"Scott", [i16], 16, (add PC)>;
def GPRegs : RegisterClass<"Scott", [i16], 16, (add R0, R1, SP)>;
