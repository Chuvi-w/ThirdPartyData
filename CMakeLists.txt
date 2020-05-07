cmake_minimum_required(VERSION 3.8)

add_library(RapidJSON INTERFACE)
target_include_directories(RapidJSON INTERFACE include/)
if(WIN32)
	target_compile_definitions(RapidJSON INTERFACE NOMINMAX)
endif()