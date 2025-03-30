#include <iostream>
#include <fstream>
#include <vector>
#include <memory>  // for std::unique_ptr
#include <string>
#include <unistd.h>

int main() {
    std::vector<std::unique_ptr<std::ofstream>> openFiles;
    const int batchSize = 1000;
    const int totalFiles = 100000;

    for (int i = 0; i < totalFiles; ++i) {
        if (i % batchSize == 0) {
            sleep(1);
        }

        std::string filename = "limit_file_" + std::to_string(i) + ".txt";
        auto file = std::make_unique<std::ofstream>(filename);
        
        if (!file->is_open()) {
            std::cerr << "Failed to open " << filename << " (limit reached?)" << std::endl;
            break;
        }

        *file << "Data " << i << std::endl;
        openFiles.push_back(std::move(file));
    }

    std::cout << "Opened " << openFiles.size() << " files." << std::endl;
    std::cout << "Press Enter to exit...";
    std::cin.get();

    return 0;
}