cmake_minimum_required(VERSION 3.15)



function(CreateSTBLib)
	 cmake_parse_arguments(
            STBL                                                               
            "INTERFACE"                                                             # list of names of the boolean arguments (only defined ones will be true)
            "LIB"      # list of names of mono-valued arguments
            "PRIVATE_DEFINITIONS;PUBLIC_DEFINITIONS"                                # list of names of multi-valued arguments (output variables are lists)
			 ${ARGN} 
    ) 
	if(STBL_INTERFACE)
		add_library(${STBL_LIB} INTERFACE)
		target_include_directories(${STBL_LIB} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
		target_compile_definitions(${STBL_LIB} INTERFACE "${STBL_PRIVATE_DEFINITIONS}" INTERFACE "${STBL_PUBLIC_DEFINITIONS}")
		
	else()
		add_library(${STBL_LIB} STATIC ${STBL_LIB}.h)
		set_property(SOURCE  ${STBL_LIB}.h PROPERTY  LANGUAGE C)
		get_property(TargetBinDir TARGET ${STBL_LIB} PROPERTY BINARY_DIR)
		#file(WRITE "${TargetBinDir}/${STBL_LIB}.c" "")
		#foreach(StbDef ${STBL_DEFINITION})
		#	file(APPEND "${TargetBinDir}/${STBL_LIB}.c" "#define ${StbDef}\n")
		#endforeach()
		#file(APPEND "${TargetBinDir}/${STBL_LIB}.c" "#include <${STBL_LIB}.h>\n")
		#target_sources(${STBL_LIB} PRIVATE "${TargetBinDir}/${STBL_LIB}.c")
		set_target_properties(${STBL_LIB} PROPERTIES LINKER_LANGUAGE C)
		target_include_directories(${STBL_LIB} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
		SET_TARGET_PROPERTIES (${STBL_LIB} PROPERTIES FOLDER STB_Libraries)
		target_compile_definitions(${STBL_LIB} PRIVATE "${STBL_PRIVATE_DEFINITIONS}" PUBLIC "${STBL_PUBLIC_DEFINITIONS}")
	endif()
endfunction()



CreateSTBLib(LIB stb PRIVATE_DEFINITIONS STB_DEFINE)
CreateSTBLib(LIB stb_c_lexer PRIVATE_DEFINITIONS STB_C_LEXER_IMPLEMENTATION)
CreateSTBLib(LIB stb_image PRIVATE_DEFINITIONS STB_IMAGE_IMPLEMENTATION)
CreateSTBLib(LIB stb_image_resize PRIVATE_DEFINITIONS STB_IMAGE_RESIZE_IMPLEMENTATION)
CreateSTBLib(LIB stb_image_write PRIVATE_DEFINITIONS  STB_IMAGE_WRITE_IMPLEMENTATION)
CreateSTBLib(LIB stb_dxt PRIVATE_DEFINITIONS  STB_DXT_IMPLEMENTATION)
#CreateSTBLib(LIB stb_voxel_render PRIVATE_DEFINITIONS  STB_VOXEL_RENDER_STATIC  STB_VOXEL_RENDER_IMPLEMENTATION STBVOX_CONFIG_MODE=20)
CreateSTBLib(LIB stb_perlin PRIVATE_DEFINITIONS  STB_PERLIN_IMPLEMENTATION)
CreateSTBLib(LIB stb_truetype PRIVATE_DEFINITIONS  STB_TRUETYPE_IMPLEMENTATION)
CreateSTBLib(LIB stb_easy_font INTERFACE )
#add_library(stb INTERFACE)
#target_include_directories(stb INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
