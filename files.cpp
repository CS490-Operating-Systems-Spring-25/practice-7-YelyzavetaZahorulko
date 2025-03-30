#include <iostream>
#include <fstream>
#include <vector>
#include <memory>  // for std::unique_ptr
#include <string>

int main() {
    std::vector<std::unique_ptr<std::ofstream>> openFiles;
    const int maxFiles = 10;

    for (int i = 0; i < maxFiles; ++i) {
        std::string filename = "file_" + std::to_string(i) + ".txt";
        auto file = std::make_unique<std::ofstream>(filename);
        
        if (!file->is_open()) {
            std::cerr << "Failed to open " << filename << std::endl;
            continue;
        }

        *file << "Test data " << i << std::endl;
        openFiles.push_back(std::move(file));
    }

    std::cout << "Opened " << openFiles.size() << " files." << std::endl;
    std::cout << "Press Enter to exit...";
    std::cin.get();

    return 0;
}