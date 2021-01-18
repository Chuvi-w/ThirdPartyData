cmake_minimum_required(VERSION 3.15)

#$ grep -nr "Define 'cimg_use_" ./
##./CImg.h:275:// Define 'cimg_use_vt100' to allow output of color messages on VT100-compatible terminals.
##./CImg.h:290:// Define 'cimg_use_openmp' to enable OpenMP support (requires OpenMP 3.0+).
##./CImg.h:409:// Define 'cimg_use_opencv' to enable OpenCV support.
##./CImg.h:444:// Define 'cimg_use_png' to enable LibPNG support.
##./CImg.h:457:// Define 'cimg_use_jpeg' to enable LibJPEG support.
##./CImg.h:471:// Define 'cimg_use_tiff' to enable LibTIFF support.
#./CImg.h:488:// Define 'cimg_use_minc2' to enable LibMINC2 support.
##./CImg.h:501:// Define 'cimg_use_zlib' to enable Zlib support.
##./CImg.h:514:// Define 'cimg_use_curl' to enable libcurl support.
##./CImg.h:525:// Define 'cimg_use_magick' to enable Magick++ support.
#./CImg.h:536:// Define 'cimg_use_fftw3' to enable libFFTW3 support.
#./CImg.h:550:// Define 'cimg_use_board' to enable Board support.
#./CImg.h:562:// Define 'cimg_use_openexr' to enable OpenEXR support.
#./CImg.h:586:// Define 'cimg_use_tinyexr' to enable TinyEXR support.
##./CImg.h:599:// Define 'cimg_use_lapack' to enable LAPACK support.



add_library(CImg INTERFACE)
target_include_directories(CImg INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
#target_precompile_headers(CImg INTERFACE CImg.h)

#add_library(CImgAll INTERFACE)
#target_include_directories(CImgAll INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
#target_precompile_headers(CImgAll INTERFACE CImgAll.h)
set(CIMG_DEBUG_DEPENDS ON)
macro(PRINT_CIMG_DEBUG Text)
    if(CIMG_DEBUG_DEPENDS)
        message(STATUS "CImg: ${Text}")
    endif()
endmacro()
macro(PRINT_CIMG_PACK_FOUND Package)
    PRINT_CIMG_DEBUG("${Package}_FOUND=${${Package}_FOUND}")
endmacro()

target_compile_definitions(CImg INTERFACE cimg_use_vt100)
if(NOT WIN32)
    FIND_PACKAGE(X11 REQUIRED)
    PRINT_CIMG_PACK_FOUND(X11)
    if(X11_FOUND)
        if(NOT APPLE)
            if(TARGET X11::Xext)
                PRINT_CIMG_DEBUG("cimg_use_xshm=true")
                target_compile_definitions(CImg INTERFACE cimg_use_xshm)
                target_link_libraries(CImg INTERFACE X11::Xext)
            else()
                PRINT_CIMG_DEBUG("cimg_use_xshm=false")
            endif()

            if(TARGET X11::Xrandr)
                PRINT_CIMG_DEBUG("cimg_use_xrandr=true")
                target_compile_definitions(CImg INTERFACE cimg_use_xrandr)
                target_link_libraries(CImg INTERFACE X11::Xrandr)
            else()
                PRINT_CIMG_DEBUG("cimg_use_xrandr=false")
            endif()       
        endif()
        target_link_libraries(CImg INTERFACE X11::X11)
    endif()
    FIND_PACKAGE(Threads REQUIRED)
    target_link_libraries(CImg INTERFACE Threads::Threads)
else()
    target_link_libraries(CImg INTERFACE gdi32)
endif()


find_package(OpenMP)
PRINT_CIMG_PACK_FOUND(OpenMP)
if(OpenMP_CXX_FOUND)
    target_compile_definitions(CImg INTERFACE cimg_use_openmp)
    target_link_libraries(CImg INTERFACE OpenMP::OpenMP_CXX)
endif()

FIND_PACKAGE(OpenCV QUIET)
PRINT_CIMG_PACK_FOUND(OpenCV)
if (OpenCV_FOUND)
    target_compile_definitions(CImg INTERFACE cimg_use_opencv)
    target_include_directories(CImg INTERFACE  ${OpenCV_INCLUDE_DIRS})
    target_link_directories(CImg INTERFACE ${OpenCV_LIB_DIRS})
    target_link_libraries(CImg INTERFACE ${OpenCV_LIBS})
endif()

FIND_PACKAGE(JPEG QUIET)
PRINT_CIMG_PACK_FOUND(JPEG)
if(JPEG_FOUND)
    target_compile_definitions(CImg INTERFACE cimg_use_jpeg)
    target_link_libraries(CImg INTERFACE JPEG::JPEG)
endif()

FIND_PACKAGE(TIFF QUIET)
PRINT_CIMG_PACK_FOUND(TIFF)
if(TIFF_FOUND)
  target_compile_definitions(CImg INTERFACE cimg_use_tiff)
  target_link_libraries(CImg INTERFACE TIFF::TIFF)
endif()

FIND_PACKAGE(PNG QUIET)
FIND_PACKAGE(ZLIB QUIET)
PRINT_CIMG_PACK_FOUND(ZLIB)
PRINT_CIMG_PACK_FOUND(PNG)
if (ZLIB_FOUND)
    target_compile_definitions(CImg INTERFACE cimg_use_zlib)
    target_link_libraries(CImg INTERFACE ZLIB::ZLIB)
    # PNG requires ZLIB
    if(PNG_FOUND)
        target_compile_definitions(CImg INTERFACE cimg_use_png)
        target_link_libraries(CImg INTERFACE PNG::PNG)
    endif()
endif()


FIND_PACKAGE(LAPACK QUIET)
FIND_PACKAGE(BLAS QUIET)
PRINT_CIMG_PACK_FOUND(LAPACK)
PRINT_CIMG_PACK_FOUND(BLAS)
if(LAPACK_FOUND AND BLAS_FOUND)
    target_compile_definitions(CImg INTERFACE cimg_use_lapack)
    target_link_libraries(CImg INTERFACE LAPACK::LAPACK BLAS::BLAS)
endif()

find_package(ImageMagick COMPONENTS Magick++ MagickCore QUIET)
PRINT_CIMG_PACK_FOUND(ImageMagick_Magick++)
PRINT_CIMG_PACK_FOUND(ImageMagick_MagickCore)
if(ImageMagick_FOUND)

    target_compile_definitions(CImg INTERFACE cimg_use_magick)
    target_include_directories(CImg INTERFACE ${ImageMagick_Magick++_INCLUDE_DIRS})
    target_link_libraries(CImg INTERFACE ${ImageMagick_Magick++_LIBRARIES} ${ImageMagick_LIBRARIES})

    # Find Imagemagick Library directory
    get_filename_component(MAGICK_LIB_DIR ${ImageMagick_MagickCore_LIBRARY} DIRECTORY)
    # Find where Magick++-config lives
    file(GLOB_RECURSE MAGICK_CONFIG FOLLOW_SYMLINKS ${MAGICK_LIB_DIR}/Magick++-config)
    PRINT_CIMG_DEBUG("MAGICK_CONFIG=${MAGICK_CONFIG}")
    if(EXISTS ${MAGICK_CONFIG})
        # Ask about CXX and lib flags/locations
        set(MAGICK_CONFIG ${MAGICK_CONFIG} CACHE string "Path to Magick++-config utility")
        execute_process(COMMAND "${MAGICK_CONFIG}" "--cxxflags" OUTPUT_VARIABLE MAGICK_CXX_FLAGS)
        execute_process(COMMAND "${MAGICK_CONFIG}" "--libs" OUTPUT_VARIABLE MAGICK_LD_FLAGS)
        # Add these to cache
        set(MAGICK_CXX_FLAGS "${MAGICK_CXX_FLAGS}" CACHE string "ImageMagick configuration specific compilation flags." )
        set(MAGICK_LD_FLAGS  "${MAGICK_LD_FLAGS}" CACHE string "ImageMagick configuration specific linking flags.")
        # Split into list:
        string(REGEX MATCHALL "([^\ ]+)" MAGICK_CXX_FLAGS "${MAGICK_CXX_FLAGS}")
        string(REGEX MATCHALL "([^\ ]+)" MAGICK_LD_FLAGS "${MAGICK_LD_FLAGS}")
        # Remove trailing whitespace (CMAKE warns about this)
        string(STRIP "${MAGICK_CXX_FLAGS}" MAGICK_CXX_FLAGS)
        string(STRIP "${MAGICK_LD_FLAGS}" MAGICK_LD_FLAGS)

        target_compile_options(CImg INTERFACE ${MAGICK_CXX_FLAGS})
        target_link_libraries(CImg INTERFACE ${MAGICK_LD_FLAGS})

        PRINT_CIMG_DEBUG("MAGICK_CXX_FLAGS=${MAGICK_CXX_FLAGS}")
        PRINT_CIMG_DEBUG("MAGICK_LD_FLAGS=${MAGICK_LD_FLAGS}")
    endif()
endif(ImageMagick_FOUND)


FIND_PACKAGE(CURL QUIET)
PRINT_CIMG_PACK_FOUND(CURL)
if(CURL_FOUND)
  target_compile_definitions(CImg INTERFACE cimg_use_curl)
  target_link_libraries(CImg INTERFACE CURL::libcurl)
endif()



