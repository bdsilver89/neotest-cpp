cmake_minimum_required(VERSION 3.21)
project(neotest-cpp-cmake-example CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(CTest)

add_subdirectory(src/catch2)
