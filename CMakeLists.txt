cmake_minimum_required(VERSION 3.8)

add_library(QrCode STATIC QrCode.cpp QrCode.hpp)
target_include_directories(QrCode PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(QrCodeGeneratorDemo QrCodeGeneratorDemo.cpp)
target_link_libraries(QrCodeGeneratorDemo QrCode)

add_executable(QrCodeGeneratorWorker QrCodeGeneratorWorker.cpp)
target_link_libraries(QrCodeGeneratorWorker QrCode)

SET_TARGET_PROPERTIES (QrCode PROPERTIES FOLDER QrCode)
SET_TARGET_PROPERTIES (QrCodeGeneratorDemo PROPERTIES FOLDER QrCode/Apps)
SET_TARGET_PROPERTIES (QrCodeGeneratorWorker PROPERTIES FOLDER QrCode/Apps)