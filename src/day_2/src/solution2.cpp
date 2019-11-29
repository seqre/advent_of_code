#include <iostream>
#include <string>

const int SIZE = 250;
const int LENGTH = 26;

int main () {
    std::string tab[SIZE];

    int diff = 0;

    for (int i = 0; i < SIZE; i++) {
        std::cin >> tab[i];
        //std::cout << tab[i] << std::endl;
    }

    int i, j;
    for (i = 0; i < SIZE; i++) {
        for (j = i + 1; j < SIZE; j++) {
            diff = 0;

            for (int k = 0; k < LENGTH; k++){
                if(tab[i][k] != tab[j][k]) {
                    diff++;
                }
            }

            if (diff == 1){
                std::cout << "xD" << std::endl;
                for (int k = 0; k < 26; k++){
                    if(tab[i][k] == tab[j][k]){
                        std::cout << tab[i][k];
                    }
                }
                std::cout << std::endl;
                break;
            }
        }
    }
}
