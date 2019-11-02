#ifndef ADVENTOFCODE_2018_MAIN_H
#define ADVENTOFCODE_2018_MAIN_H

std::string solutionsExecString(int number) {
    return ("./days/day_" + std::to_string(number) + "/solution" + std::to_string(number));
}

void executeSolution(int number) {
    std::cout << solutionsExecString(number) << std::endl;
}

#endif //ADVENTOFCODE_2018_MAIN_H
