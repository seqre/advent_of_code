#include <iostream>

using namespace std;

const int SIZE =  1293;

int main() {
    int tab[SIZE][4];
    int plane[SIZE][SIZE] {0};
    
    /*  tab[][0] = x
        tab[][1] = y
        tab[][2] = len_x
        tab[][3] = len_y
    */

    int input;
    for(int i = 0; i < SIZE; i++) {
        cin >> input;
        for (int j = 0; j < 4; j++)
            cin >> tab[i][j];

        for (int x = 0; x < tab[i][2]; x++) {
            for (int y = 0; y < tab[i][3]; y++) {
                plane [ tab[i][0] + x ]
                      [ tab[i][1] + y ]++;
            }
        }
    }

    int counter = 0;
    for (int x = 0; x < SIZE; x++) {
        for (int y = 0; y < SIZE; y++) {
            if (plane[x][y] >= 2) counter++; 
        }
    }

    cout << counter << endl;

    int inside = 0;
    for(int i = 0; i < SIZE; i++) {
        inside = 0;
        for (int x = 0; x < tab[i][2]; x++) {
            for (int y = 0; y < tab[i][3]; y++) {
                inside += plane [ tab[i][0] + x ]
                                [ tab[i][1] + y ];
            }
        }
        if (inside == tab[i][2] * tab[i][3]) cout << i + 1 << endl;
    }
}