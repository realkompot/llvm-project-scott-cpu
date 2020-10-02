### Overview

This LLVM project fork is a toy mini-project that attempts to introduce a C compiler for a 16-bit version of the Scott CPU from [_But How Do It Know?_](http://buthowdoitknow.com/) by J. Clark Scott.
The goal was to be able to create & compile & run a simple program using this great simulator: [Simple Computer](https://github.com/djhworld/simple-computer/).

### Example program
 [GIF](./_scott-cpu/snake.gif), [Source](./_scott-cpu/snake.c), [Assembly](./_scott-cpu/snake.s), [Binary](/_scott-cpu/snake.bin).
### Usage

1. Compile [llvm + clang](https://llvm.org/docs/GettingStarted.html) first (build type == MinSizeRel saves disk space as the debug binaries are 45GBs in size on my drive).
2. Compile a program:
   - clang -S [-O3] --target=scott your_program.c (assembly file)
   - clang -c [-O3] --target=scott your_program.c (.o binary file)
3. Run the resulting .o file using the simulator: https://github.com/djhworld/simple-computer#running

### Implementation

Due to my limited C++/compiler/llvm knowledge, generating efficient code wasn't a concern, I tried to come up with the simplest/hackiest solution that worked.
I started by copying a RISC backend, then cut it down to the necessary level of simplicity and tweaked a little bit.
Details:
 - R3 serves as the stack register.
 - Calling convention:
    - 1st arg is passed in R0, the rest - on the stack.
    - 1st 16-bit word is returned in R1, the rest - on the stack.
 - Stack grows down (high -> low address). During function prologue stack space for local vars gets allocated like this: SP = SP - (Locals size + 1).
   In function, SP + 0 is reserved to store return address for subsequent calls, SP + 1..N - stack slots for local variables.
   On function exit we adjust SP back and jump: SP = SP + (Locals size + 1); JMPR SP.
 - Functions io_data_in, io_data_out, io_address_out are replaced by I/O instructions [IN Data, RX], [OUT Data, RX], [OUT Addr, RX] respectively.
   Normaly, there should be inline asm support to be able to use these instructions but for my purpose this approach works well too.
 - Object files (.o) can be executed directly with the simulator.
   To produce .o file the compiler flushes "DATA R3, 0xFFF0" to set up the stack register, followed by code and data.
   For this reason execution starts with the first defined function :=)
 - The target is the original Scott CPU scaled to 16 bits. This means byte size is 16 bit as well.
   This situation is super rare and llvm is not made to handle this correctly (why would it be?), especially on the llvm and backend sides (clang is fine).
   There are many places scattered around the codebase where you can see code like this: SizeInBytes = SizeInBits / 8.
   I made adjustments as the debugger was hitting such lines, but there are many more of them left! For this reason alone the whole thing is buggy and obv can't be called reliable :=)
