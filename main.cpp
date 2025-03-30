#include <iostream>
#include <fstream>
#include <unistd.h> // for sleep()

int main() {
    std::ofstream outFile("test.txt");
    if (!outFile.is_open()) {
        std::cerr << "Failed to open test.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < 1000; ++i) {
        outFile << "Line " << i << std::endl << std::flush;
        sleep(1);
    }

    outFile.close();
    return 0;
}