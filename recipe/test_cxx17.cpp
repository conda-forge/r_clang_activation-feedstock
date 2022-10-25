#include <iostream>
#include <string_view>

void test() {
#ifndef __clang__
  useless code that will error
#endif
  constexpr std::string_view unicode[] {
        "▀▄─", "▄▀─", "▀─▄", "▄─▀"
  };

  std::cout << unicode << std::endl;
}

