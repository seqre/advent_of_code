cmake_minimum_required(VERSION 3.15)
project(solution2)
set(CMAKE_CXX_STANDARD 17)

add_executable("${PROJECT_NAME}_1" src/solution.cpp)
add_executable("${PROJECT_NAME}_2" src/solution2.cpp)

configure_file("${PROJECT_SOURCE_DIR}/input.txt" "${PROJECT_BINARY_DIR}/input.txt")