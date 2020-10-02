#ifndef SCOTTEMULATOR_H
#define SCOTTEMULATOR_H


namespace llvm {
  namespace scott {
    // A little bit ugly, but it was the easiest way to do what I wanted.
    // This is simply encoded DATA R3, 0xFFF0.
    // In this way, when it's emitted and followed by the code, we're able to execute .o file directly.
    // Execution starts with the first defined function.
    const char InitialSPValueInstrBytes[] = { 35, 0, -16, -1 };

    // Scott CPU simulator loads the program at 0x500 offset + we add 2 bytes of InitialSPValueInstrBytes.
    const unsigned int ScottLoaderOffset = 0x500 + sizeof(InitialSPValueInstrBytes) / 2;

    unsigned long calculateEmulatorAddress(unsigned long offset);
  }
}

#endif // SCOTTEMULATOR_H
