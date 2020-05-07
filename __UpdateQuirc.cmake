cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_Quirc

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/QuircGit/)

git_clone(
        PROJECT_NAME    QuircGit
        GIT_URL         https://github.com/dlbeer/quirc.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(QuircGit_CLONE_RESULT)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/lib/)	
	file(COPY ${QuircGit_SOURCE_DIR}/lib DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${QuircGit_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "Quirc updated")
endif()
