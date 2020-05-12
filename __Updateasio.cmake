cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_asio

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/AsioGit/)
git_clone(
        PROJECT_NAME    AsioGit
        GIT_URL         https://github.com/chriskohlhoff/asio.git
        GIT_BRANCH      master
        DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(AsioGit_CLONE_RESULT)
    file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE_1_0.txt)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/src)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/include)
	file(COPY ${AsioGit_SOURCE_DIR}/asio/include DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${AsioGit_SOURCE_DIR}/asio/LICENSE_1_0.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${AsioGit_SOURCE_DIR}/asio/src/asio.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR}/src)
	file(COPY ${AsioGit_SOURCE_DIR}/asio/src/asio_ssl.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR}/src)
	message(STATUS "ASIO updated")
endif()