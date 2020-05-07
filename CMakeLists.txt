cmake_minimum_required(VERSION 3.8)
add_library(md4c src/md4c.c src/md4c.h)
target_compile_definitions(md4c PRIVATE MD4C_USE_UTF8 )
target_include_directories(md4c PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)
add_library(md4c-html src/md4c-html.c src/md4c-html.h src/entity.c src/entity.h)
target_include_directories(md4c-html PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)


