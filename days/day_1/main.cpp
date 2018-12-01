#include <iostream>
#include <unordered_set>
#include <list>

int main () {
    int64_t n = 0;
    std::unordered_set<int64_t> xD;
    int temp, i = 0;
    std::list<int64_t> xDD;

    xD.emplace(n);

    while(std::cin >> temp) {
        xDD.push_back(temp);
        i++;
    }
    int j = 0;
    while (true){
        temp = xDD.front();
        n += temp;
        if ( xD.count(n) > 0 ){
            std::cout << n;
            break;
        } else xD.emplace(n);
        xDD.pop_front();
        xDD.push_back(temp);
        j++;
    }
}