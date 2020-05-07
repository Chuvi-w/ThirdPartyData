## Sources
set(serial_SRCS
        src/serial.cc
        include/serial/serial.h
        include/serial/v8stdint.h
        )
if (APPLE)
    # If OSX
    list(APPEND serial_SRCS src/impl/unix.cc)
    list(APPEND serial_SRCS src/impl/list_ports/list_ports_osx.cc)
elseif (UNIX)
    # If unix
    list(APPEND serial_SRCS src/impl/unix.cc)
    list(APPEND serial_SRCS src/impl/list_ports/list_ports_linux.cc)
else ()
    # If windows
    list(APPEND serial_SRCS src/impl/win.cc)
    list(APPEND serial_SRCS src/impl/list_ports/list_ports_win.cc)
endif ()

 list(APPEND serial_SRCS CSerial.cpp)
 
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
add_library(serial STATIC ${serial_SRCS})

target_include_directories(serial PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(MSVC)
	target_link_libraries(serial setupapi)
endif()
 