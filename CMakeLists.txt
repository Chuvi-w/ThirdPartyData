cmake_minimum_required(VERSION 3.8)

add_library(Quirc STATIC 
				lib/decode.c
				lib/identify.c
				lib/quirc.c
				lib/quirc.h
				lib/quirc_internal.h
				lib/version_db.c
				)
target_include_directories(Quirc PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/lib)