cmake_minimum_required(VERSION 3.8)
find_package(OpenGL)
find_package(GLUT)

add_library(tigr STATIC tigr.c tigr.h glext.h wglext.h KHR/khrplatform.h)
target_compile_definitions(tigr PUBLIC TIGR_GAPI_GL)
target_include_directories(tigr PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(tigr PRIVATE ${OPENGL_gl_LIBRARY})