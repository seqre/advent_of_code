#include <iostream>
#include <fstream>
#include <filesystem>
#include <set>

void solution(std::ifstream &in, std::ofstream &out) {
    int current_frequency = 0;
    int repeated_frequency = 0;
    bool frequency_set = false;
    int s = 0;
    std::set<int> frequencies = {0};


    while (in >> s) {
        current_frequency += s;
        if (!frequency_set && frequencies.find(current_frequency) == frequencies.end()) {
            frequencies.insert(current_frequency);
        } else {
            repeated_frequency = current_frequency;
            frequency_set = true;
        }
    }

    out << current_frequency << std::endl;
    out << repeated_frequency << std::endl;
}

int main () {
    std::cout << "Current path is " << std::filesystem::current_path() << '\n';
    std::ifstream in("input.txt");
    std::ofstream out("result.txt");
    std::cout << "Input file: " << std::boolalpha << in.is_open() << std::endl;
    std::cout << "Output file: " << std::boolalpha << out.is_open() << std::endl;

    solution(in, out);

    in.close();
    out.close();

    return 0;
}