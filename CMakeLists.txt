cmake_minimum_required(VERSION 3.15)


add_library(pugixml pugiconfig.hpp pugixml.cpp pugixml.hpp)
target_include_directories(pugixml PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


