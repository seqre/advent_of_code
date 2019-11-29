#include <iostream>
#include <vector>
#include <cctype>

int main () {
    std::vector<char> polymer;
    char ch;

    bool change = false;

    while(std::cin >> ch) polymer.emplace_back(ch);
    std::vector<char> backup = polymer;

    do {
        change = false;
        for(int i = 0; i < polymer.size() - 1; i++) {
            if( isupper(polymer[i]) ? 
              ( isupper(polymer[i+1]) ? false : polymer[i] == char(toupper(polymer[i + 1])) ) :
              ( isupper(polymer[i+1]) ? polymer[i] == char(tolower(polymer[i + 1])) : false ) ) {
                polymer.erase(polymer.begin() + i);
                polymer.erase(polymer.begin() + i);

                change = true;
            }
        }
    } while(change);

    std::cout << polymer.size() << std::endl;

    int min_size = backup.size();

    for (int j = 0; j < 25; j++) {
        std::vector<char> m_polymer = backup;

        for(int i = 0; i < m_polymer.size() - 1; i++) {
            if(m_polymer[i] == char(j+97) || m_polymer[i] == char(j+65)){
                m_polymer.erase(m_polymer.begin() + i);
                i--;
            }
        }

        do {
            change = false;
            for(int i = 0; i < m_polymer.size() - 1; i++) {
                if( isupper(m_polymer[i]) ? 
                ( isupper(m_polymer[i+1]) ? false : m_polymer[i] == char(toupper(m_polymer[i + 1])) ) :
                ( isupper(m_polymer[i+1]) ? m_polymer[i] == char(tolower(m_polymer[i + 1])) : false ) ) {
                    m_polymer.erase(m_polymer.begin() + i);
                    m_polymer.erase(m_polymer.begin() + i);

                    change = true;
                }
            }
        } while(change);

        if (min_size > m_polymer.size()) min_size = m_polymer.size();
    }

    std::cout << min_size << std::endl;
}