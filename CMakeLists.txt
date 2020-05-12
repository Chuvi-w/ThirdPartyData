
cmake_minimum_required(VERSION 3.8)
add_library(asio src/asio.cpp)

if(WIN32)
macro(get_WIN32_WINNT version)
    if (WIN32 AND CMAKE_SYSTEM_VERSION)
        set(ver ${CMAKE_SYSTEM_VERSION})
        string(REPLACE "." "" ver ${ver})
        string(REGEX REPLACE "([0-9])" "0\\1" ver ${ver})

        set(${version} "0x${ver}")
    endif()
endmacro()

get_WIN32_WINNT(Win32Ver)
target_compile_definitions(asio _WIN32_WINNT=${Win32Ver})
endif()

target_include_directories(asio PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_compile_definitions(asio PUBLIC ASIO_SEPARATE_COMPILATION)

if (TARGET OpenSSL::SSL AND TARGET OpenSSL::Crypto)
	add_library(asio_ssl src/asio_ssl.cpp)
	target_include_directories(asio_ssl PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
	target_link_libraries(asio_ssl OpenSSL::SSL OpenSSL::Crypto)
	target_compile_definitions(asio_ssl PUBLIC ASIO_SEPARATE_COMPILATION)
	if(WIN32)
		target_compile_definitions(asio_ssl _WIN32_WINNT=${Win32Ver})
		target_link_libraries(asio_ssl Crypt32)
	endif()
endif()
