cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_PUGIXML

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR ${CMAKE_BINARY_DIR}/_ThirdPartyGit CACHE INTERNAL "" FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/pugixml/)
git_clone(
        PROJECT_NAME    pugixml
        GIT_URL         https://github.com/zeux/pugixml.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(pugixml_CLONE_RESULT)
	
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/pugiconfig.hpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/pugixml.cpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/pugixml.hpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/LICENSE.md)
	
	
	file(COPY ${pugixml_SOURCE_DIR}/src/pugiconfig.hpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${pugixml_SOURCE_DIR}/src/pugixml.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${pugixml_SOURCE_DIR}/src/pugixml.hpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${pugixml_SOURCE_DIR}/LICENSE.md DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	
	message(STATUS "pugixml updated")
endif()
