#include <iostream>
#include <vector>
#include <stack>
#include <queue>

using namespace std;

// 9 - 5158916779
// 5 - 0124515891
// 18 - 9251071085
// 2018 - 5941429882

const long INPUT = 360781;
const int X = 2018;

int main () {
    std::vector<int> recipes = {3,7};
    int elves[2] {0,1};
    stack<int> temp;
    queue<int> result;
    int sum = 0;

    cout << "Init check: " << elves[0] << "|" << elves[1] << endl;

    while (recipes.size() <= X+11) {
        for (int j = 0; j < recipes.size(); j++) cout << (j==elves[0] ? "[" : (j==elves[1] ? "{" : "")) << recipes[j] << (j==elves[0] ? "]" : (j==elves[1] ? "}" : "")) << '\t';
        cout << endl;
        
        sum = recipes[elves[0]] + recipes[elves[1]];
        
        while (sum > 0) {
            temp.push(sum%10);
            sum = sum/10;
        }

        while (!temp.empty()) {
            recipes.emplace_back(temp.top());
            temp.pop();
        }

        if (recipes.size() != 2) {
            elves[0] = (elves[0] + (recipes[elves[0]] + 1)) % recipes.size();
            elves[1] = (elves[1] + (recipes[elves[1]] + 1)) % recipes.size();
            //cout << elves[0] << "|" << elves[1] << endl;
        }
    }
    
    for (int i = X; i < X+10; i++) cout << recipes[i];
    cout << endl;
    
}