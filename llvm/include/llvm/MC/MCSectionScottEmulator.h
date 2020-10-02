#ifndef MCSECTIONSCOTTEMULATOR_H
#define MCSECTIONSCOTTEMULATOR_H

#include "llvm/MC/MCSection.h"

namespace llvm {

class MCSymbol;
class StringRef;
class raw_ostream;

class MCSectionScottEmulator final : public MCSection {
  SmallString<8> SectionName;

private:
  friend class MCContext;
  MCSectionScottEmulator(StringRef Name, SectionKind K, MCSymbol *Begin);

public:
  ~MCSectionScottEmulator();

  StringRef getSectionName() const { return SectionName; }

  void PrintSwitchToSection(const MCAsmInfo &MAI, const Triple &T,
                            raw_ostream &OS,
                            const MCExpr *Subsection) const override;
  bool UseCodeAlign() const override { return false; }
  bool isVirtualSection() const override { return false; }

  static bool classof(const MCSection *S) {
    return S->getVariant() == SV_ScottEmulator;
  }
};

} // end namespace llvm

#endif // MCSECTIONSCOTTEMULATOR_H
