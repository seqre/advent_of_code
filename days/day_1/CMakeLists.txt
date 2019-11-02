cmake_minimum_required(VERSION 3.15)
project(solution1)

add_executable(${PROJECT_NAME} src/solution1.cpp)

configure_file("${PROJECT_SOURCE_DIR}/input.txt" "${PROJECT_BINARY_DIR}/input.txt")