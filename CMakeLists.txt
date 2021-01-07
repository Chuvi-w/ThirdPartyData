cmake_minimum_required(VERSION 3.15)

add_library(tinyxml2 STATIC tinyxml2.cpp tinyxml2.h)
target_include_directories(tinyxml2 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(tinyxml2ex INTERFACE)
target_include_directories(tinyxml2ex INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

if(MSVC)
      target_compile_definitions(tinyxml2 PUBLIC _CRT_SECURE_NO_WARNINGS)
endif(MSVC)
	