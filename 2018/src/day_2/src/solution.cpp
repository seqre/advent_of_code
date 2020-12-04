#include <iostream>
#include <string>
#include <map>

using namespace std;

int main () {
    int count_2 = 0, count_3 = 0;
    bool c2 = true, c3 = true;
    int char_count[250][26] {0};
    string input;

    int i = 0, j = 0;
    while(cin >> input) {
        c2 = true;
        c3 = true;

        for (char ch : input) {
            j = ch - 'a';
            char_count[i][j]++;
        }

        for(int k = 0; k < 26; k++) {
            if(char_count[i][k] == 2 && c2) {
                count_2++;
                c2 = false;
            }
            if(char_count[i][k] == 3 && c3) {
                count_3++;
                c3 = false;
            }
        }

        i++;
    }
    std::cout<< count_2 * count_3 << std::endl;
}

/*
for(char i : alphabet) std::cout << char_count[alphabet[i]] << "|";

        if(char_count[i] == 2 && c2) {
            count_2++;
            c2 = false;
        }
        if(char_count[i] == 3 && c3) {
            count_3++;
            c3 = false;
        }
*/