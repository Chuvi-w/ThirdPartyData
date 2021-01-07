cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_GIT_UTILS

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR ${CMAKE_BINARY_DIR}/_ThirdPartyGit CACHE INTERNAL "" FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/cmake_git_clone/)
git_clone(
        PROJECT_NAME    cmake_git_clone
        GIT_URL         https://github.com/tschuchortdev/cmake_git_clone.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(cmake_git_clone_CLONE_RESULT)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/GitUtils.cmake)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/Utils.cmake)
	file(COPY ${cmake_git_clone_SOURCE_DIR}/cmake/GitUtils.cmake DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${cmake_git_clone_SOURCE_DIR}/cmake/Utils.cmake DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${cmake_git_clone_SOURCE_DIR}/LICENSE.TXT DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "cmake_git_clone updated")
endif()