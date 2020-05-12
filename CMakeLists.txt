
cmake_minimum_required(VERSION 3.8)
add_library(asio src/asio.cpp)
target_include_directories(asio PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)


if (TARGET OpenSSL::SSL AND TARGET OpenSSL::Crypto)
	add_library(asio_ssl src/asio_ssl.cpp)
	target_include_directories(asio PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
	target_link_libraries(HttpLib OpenSSL::SSL OpenSSL::Crypto)
	if(WIN32)
		target_link_libraries(HttpLib Crypt32)
	endif()
endif()
