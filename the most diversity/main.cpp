// C++ — your Visual Studio build still works from here.
#include <iostream>
#include <string_view>

int main() {
    constexpr std::string_view banner = R"(
  ╔══════════════════════════════════════════════════════════╗
  ║           THE MOST DIVERSITY — museum repo               ║
  ║  Languages · formats · configs · scripts · i18n · more   ║
  ╚══════════════════════════════════════════════════════════╝
)";
    std::cout << banner;
    std::cout << "Open README.md and browse folders. Run scripts/run-samples.ps1 to taste more.\n";
    return 0;
}
