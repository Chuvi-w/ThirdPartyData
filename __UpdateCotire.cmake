cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_COTIRE

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR ${CMAKE_BINARY_DIR}/_ThirdPartyGit CACHE INTERNAL "" FORCE)
endif()


git_clone(
        PROJECT_NAME    cotire
        GIT_URL        	https://github.com/sakra/cotire.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(cotire_CLONE_RESULT)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/cotire.cmake)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/license)
	file(COPY ${cotire_SOURCE_DIR}/CMake/cotire.cmake DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${cotire_SOURCE_DIR}/license DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "cotire updated")
endif()