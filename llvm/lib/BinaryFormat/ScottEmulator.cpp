#include <assert.h>
#include "llvm/BinaryFormat/ScottEmulator.h"

using namespace llvm;
using namespace scott;

unsigned long llvm::scott::calculateEmulatorAddress(unsigned long offset)
{
  assert(!(offset % 2) && "Offset is odd!");

  return offset / 2 + ScottLoaderOffset;
}
