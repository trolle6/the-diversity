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
    std::cout << "Web museum: run scripts\\serve-museum.ps1  ->  http://127.0.0.1:8765/\n";
    std::cout << "Or browse README.md / folders. Run scripts\\run-samples.ps1 for CLI samples.\n";
    return 0;
}
