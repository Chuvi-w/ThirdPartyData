cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_UCM

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR ${CMAKE_BINARY_DIR}/_ThirdPartyGit CACHE INTERNAL "" FORCE)
endif()


git_clone(
        PROJECT_NAME    ucm
        GIT_URL         https://github.com/onqtam/ucm.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(ucm_CLONE_RESULT)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/ucm.cmake)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE.txt)
	file(COPY ${ucm_SOURCE_DIR}/cmake/ucm.cmake DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${ucm_SOURCE_DIR}/LICENSE.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "ucm updated")
endif()
