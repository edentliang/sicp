#include<iostream>

int call (int n) {
    if (n == 0){
        return 1;
    } else {
        return (1 + call (n-1));
    }
}

int main() {
    std::cout << "why" <<std::endl;
    call(3);
    return 0;
}
