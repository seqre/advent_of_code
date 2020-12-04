cmake_minimum_required(VERSION 3.15)
project(solution6)
set(CMAKE_CXX_STANDARD 17)

add_executable(${PROJECT_NAME} src/${PROJECT_NAME}.cpp)

configure_file("${PROJECT_SOURCE_DIR}/input.txt" "${PROJECT_BINARY_DIR}/input.txt")