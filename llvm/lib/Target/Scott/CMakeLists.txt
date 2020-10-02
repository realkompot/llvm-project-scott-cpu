set(LLVM_TARGET_DEFINITIONS Scott.td)

tablegen(LLVM ScottGenAsmMatcher.inc -gen-asm-matcher)
tablegen(LLVM ScottGenAsmWriter.inc -gen-asm-writer)
tablegen(LLVM ScottGenCallingConv.inc -gen-callingconv)
tablegen(LLVM ScottGenDAGISel.inc -gen-dag-isel)
tablegen(LLVM ScottGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM ScottGenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM ScottGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM ScottGenSubtargetInfo.inc -gen-subtarget)

add_public_tablegen_target(ScottCommonTableGen)

add_llvm_target(ScottCodeGen
  ScottAsmPrinter.cpp
  ScottInstrInfo.cpp
  ScottISelDAGToDAG.cpp
  ScottISelLowering.cpp
  ScottFrameLowering.cpp
  ScottMachineFunctionInfo.cpp
  ScottRegisterInfo.cpp
  ScottSubtarget.cpp
  ScottTargetMachine.cpp
  ScottMCInstLower.cpp
  ScottTargetObjectFile.cpp
  ScottPasses.cpp
  )

add_subdirectory(MCTargetDesc)
add_subdirectory(TargetInfo)
