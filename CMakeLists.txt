
add_library(md4c STATIC 
 md4c/md4c.c
 md4c/md4c.h
 md2html/entity.c
 md2html/entity.h

 md2html/render_html.c
 md2html/render_html.h
)

target_include_directories(md4c PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})