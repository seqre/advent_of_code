#include <iostream>
#include <string>
#include <map>

int main () {
    std::string pots = "..........", temp_pots;
    std::map<std::string, char> dependencies;

    char input;
    std::cin >> input;
    while (input != 'X') {
        pots += input;
        std::cin >> input;
    } 
    pots += "..............";
    temp_pots = pots;
    
    std::string temp;
    for (int i = 0; i < 32; ++i) {
        temp = "";
        for (int j = 0; j < 5; ++j) {
            std::cin >> input;
            temp += input;
        }
        std::cin >> input;
        dependencies[temp] = input;
    }
    
    std::cout << '\t';
    for (int i = 0; i < pots.size(); ++i) {
            std::cout << pots[i];
    } std::cout << std::endl;

    bool extend = false;
    int dots = 0;
    int offset = -10;
    int sum = 0, prev_sum = 0;

    for (int gen = 1; gen < 115; ++gen) {
        //if(gen > 10000)
        std::cout << gen << ":\t";// << std::endl;
        extend = false;
        dots = 0;

        for (int i = 2; i < pots.size()-2; ++i) {
            if( i == pots.size()-5 && pots[pots.size()-5] == '#') {
                extend = true;
            }
            temp = "";
            for (int j = 0; j < 5; ++j) {
                temp += temp_pots[i-2+j];
            }
            pots[i] = dependencies[temp];
        }
        if(extend) pots += "...";
        temp_pots = pots;
        //if(gen > 10000) {
            for (int i = 0; i < pots.size(); ++i) {
                std::cout << pots[i];
                //if (pots[i] == '.') dots++;
            } std::cout << std::endl;
        //}

        if(dots > 10) {
            pots.erase(0,5);
            offset += 5;
        }

        if(gen >= 100) {
            sum = 0;
            std::cout << '\t';
            for (int i = 0; i < pots.size(); ++i) {
                if(pots[i] == '#') {
                    //std::cout << i-10 << ' ';
                    sum += i + offset;
                }
            } 
            std::cout << sum << "|" << sum - prev_sum << std::endl;
            prev_sum = sum;
        }
    }

    
    /*
    std::cout << '\t';
    for (int i = 0; i < pots.size()/10; ++i) {
        for (int j = 0; j < 10; ++j) {
            if (i != 0) std::cout << i;
            else std::cout << ' ';
        }
    } std::cout << std::endl;

    std::cout << '\t';
    for (int i = 0; i < pots.size(); ++i) {
            std::cout << i%10;
    } std::cout << std::endl;

    std::cout << '\t';
    for (int i = 0; i < pots.size(); ++i) {
            if (pots[i] == '#') std::cout << 'X';
            else std::cout << ' ';
    } std::cout << std::endl;
    */
    
}