cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_stb

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/StbGit/)

git_clone(
        PROJECT_NAME    StbGit
        GIT_URL        	https://github.com/nothings/stb.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(StbGit_CLONE_RESULT)
	file(GLOB StbFiles ${CMAKE_CURRENT_LIST_DIR}/*.h ${CMAKE_CURRENT_LIST_DIR}/*.c)
	if(StbFiles)
		file(REMOVE ${StbFiles})
	endif()
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE)
	
	file(GLOB StbFiles ${StbGit_SOURCE_DIR}/*.h ${StbGit_SOURCE_DIR}/*.c)
	file(COPY ${StbFiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${StbGit_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(RENAME ${CMAKE_CURRENT_LIST_DIR}/stb_vorbis.c ${CMAKE_CURRENT_LIST_DIR}/stb_vorbis.h)
	message(STATUS "StbLib updated")
endif()