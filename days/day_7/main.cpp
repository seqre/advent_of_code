#include <iostream>
#include <vector>
#include <set>
#include <map>

const int N_DATA = 101;
const int ALPHABET = 26;
/*
void next_letter(std::vector<char> &result,
                 std::map<char, std::set<char>> alphabet,
                 std::map<int, std::set<char>> &frequency) {
    char ch = 'Z', temp_ch;
    int freq, it;
    bool compatibility = false;
    std::cout << "Check_1_inside" << std::endl;

    for(int i = 0; i < result.size(); i++) {
        auto it = frequency[i].begin();

        for(int j = 0; j < frequency[i].size(); j++) {
            std::cout << "Check_loop " << i << "|" << j << "|" << *it << std::endl;
            
            temp_ch = *it;
            if(temp_ch < ch) {
                for(char ch_i : alphabet[temp_ch]) {
                    auto it_i = alphabet[temp_ch].begin();
                    auto it_re = std::find(std::begin(result), std::end(result), *it_i);
                    if(it_re != std::end(result)){
                    compatibility = true;            
                    }
                }

                if (compatibility) {
                    ch = temp_ch;
                    freq = i;
                }
            }
            compatibility = false;
            it++;
        }
    }
    std::cout << "Check_2_after_loop" << std::endl;

    std::cout << ch << std::endl;

    result.push_back(ch);
    frequency[freq].erase(frequency[freq].find(ch));
    std::cout << "Check_3_after_erase" << std::endl;
}
*/
int main () {
    std::vector<char> result;
    std::map<char, std::set<char>> alphabet;
    std::map<int, std::set<char>> frequency;
    char ch, after_ch;

    for(int i = 0; i < N_DATA; i++) {
        std::cin >> ch;
        std::cin >> after_ch;
        alphabet[after_ch].insert(ch);
    }

    for(int i = 0; i < ALPHABET; i++) {
        ch = char(i + 'A');
        frequency[alphabet[ch].size()].insert(ch);
    }
    /*
    result.push_back(*(frequency[0].begin()));
    frequency[0].erase(frequency[0].begin());

    for(int i = 1; i < ALPHABET; i++) {
        std::cout << i << std::endl;
        next_letter(result, alphabet, frequency);
    }
    std::cout << "Check_after_loop" << std::endl;
    */
    for(int i = 0; i < ALPHABET; i++) {
        std::cout << i;
        for(char ch : frequency[i]) std::cout << "\t" << ch;
        std::cout << std::endl;
    }
    for(int i = 0; i < ALPHABET; i++){
        std::cout << char(i + 'A');
        for(char ch : alphabet[char(i + 'A')]) std::cout << "\t" << ch;
        std::cout << std::endl;
    }

    std::cout << std::endl;
}