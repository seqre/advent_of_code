#include <iostream>
#include <cmath>

// max: SIZE n: 50

const int SIZE = 357 + 1;

int main () {
    struct point {
        int point_x;
        int point_y;

        int closest;
        int distance;

        int area;

        int distance_from_point(int x, int y) {
            return abs(point_x - x) + abs(point_y - y);
        }
    };

    point data [50];

    int tab[SIZE][SIZE] {0};

    int cord_x, cord_y, i = 0;
    while (std::cin >> cord_x) {
        std::cin >> cord_y;

        data[i].point_x = cord_x;
        data[i].point_y = cord_y;

        data[i].closest = i;
        data[i].distance = 0;
        data[i].area = 0;

        i++;
    }

    int best_distance, temp_distance, area_distance, source, count = 0;
    for (int i = 0; i < SIZE; i++){
        for (int j = 0; j < SIZE; j++){
            best_distance = SIZE;
            area_distance = 0;
            source = 0;

            for (int k = 0; k < 50; k++){
                temp_distance = data[k].distance_from_point(i, j);
                area_distance += temp_distance;

                if (temp_distance < best_distance) {
                    best_distance = temp_distance;
                    source = k;
                }
            }

            if (i == 0 || i == SIZE - 1 ) data[source].area = -1;
            else if (j == 0 || j == SIZE - 1 ) data[source].area = -1;
            else if(data[source].area != -1) data[source].area++;

            if (area_distance < 10000) count++;
        }
    }
    
    int best_area = 0, temp_area = 0;
    for (int k = 0; k < 50; k++){
        temp_area = data[k].area;

        if(temp_area > best_area) best_area = data[k].area;
    }    

    std::cout << best_area << std::endl;
    std::cout << count << std::endl;
}