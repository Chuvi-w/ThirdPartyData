cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_TinyXML2

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/tinyxml2Git/)
file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/tinyxml2exGit/)
git_clone(
        PROJECT_NAME    tinyxml2Git
        GIT_URL         https://github.com/leethomason/tinyxml2.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

git_clone(
        PROJECT_NAME    tinyxml2exGit
        GIT_URL         https://github.com/stanthomas/tinyxml2-ex.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)


if(tinyxml2Git_CLONE_RESULT AND tinyxml2exGit_CLONE_RESULT )
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/tinyxml2.cpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/tinyxml2.h)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE.txt)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/tixml2cx.h)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/tixml2ex.h)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE)
	
	file(COPY ${tinyxml2Git_SOURCE_DIR}/tinyxml2.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${tinyxml2Git_SOURCE_DIR}/tinyxml2.h DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${tinyxml2Git_SOURCE_DIR}/LICENSE.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	
	file(COPY ${tinyxml2exGit_SOURCE_DIR}/tixml2cx.h DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${tinyxml2exGit_SOURCE_DIR}/tixml2ex.h DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${tinyxml2exGit_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	
	message(STATUS "TinyXML2 updated")
endif()