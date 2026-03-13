#include <concepts>
#include <iostream>

void print_even(std::integral auto x) {
    if (x % 2 == 0) std::cout << x << " is even\n";
}

int main() {
    print_even(4);
}
