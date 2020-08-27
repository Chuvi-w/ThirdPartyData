cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_tigr
if(0)
	if(NOT THIRD_PARTY_GIT_DIR)
	 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
	endif()

	file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/)

	file(DOWNLOAD https://bitbucket.org/rmitton/tigr/downloads/tigr.zip ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/tigr.zip SHOW_PROGRESS)
	 execute_process(
		COMMAND ${CMAKE_COMMAND} -E tar xzf  ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/tigr.zip
		WORKING_DIRECTORY ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/
		)
		
		file(COPY ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/tigr.c DESTINATION ${CMAKE_CURRENT_LIST_DIR})
		file(COPY ${THIRD_PARTY_GIT_DIR}/TiGRUpdate/tigr.h DESTINATION ${CMAKE_CURRENT_LIST_DIR})

	file(DOWNLOAD https://www.opengl.org/registry/api/GL/glext.h ${CMAKE_CURRENT_LIST_DIR}/glext.h SHOW_PROGRESS)
	file(DOWNLOAD  https://www.opengl.org/registry/api/GL/wglext.h ${CMAKE_CURRENT_LIST_DIR}/wglext.h SHOW_PROGRESS)
	file(DOWNLOAD  https://www.khronos.org/registry/EGL/api/KHR/khrplatform.h ${CMAKE_CURRENT_LIST_DIR}/KHR/khrplatform.h SHOW_PROGRESS)
	file(READ ${CMAKE_CURRENT_LIST_DIR}/tigr.h tigr_text)
	string(REPLACE "#define TIGR_GAPI_D3D9" "#define TIGR_GAPI_GL" tigr_text "${tigr_text}")
	file(WRITE ${CMAKE_CURRENT_LIST_DIR}/tigr.h "${tigr_text}")
endif()
message(STATUS "tigr updated")
