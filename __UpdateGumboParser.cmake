cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_GumboParser

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/GumboParserGit/)
git_clone(
        PROJECT_NAME    GumboParserGit
        GIT_URL        	https://github.com/google/gumbo-parser.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(GumboParserGit_CLONE_RESULT)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/*.c ${CMAKE_CURRENT_LIST_DIR}/*.h)
	file(GLOB GumboParserFiles ${GumboParserGit_SOURCE_DIR}/src/*.h ${GumboParserGit_SOURCE_DIR}/src/*.c)
	file(COPY ${GumboParserFiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
	file(COPY ${GumboParserGit_SOURCE_DIR}/visualc/include DESTINATION ${CMAKE_CURRENT_LIST_DIR}/visualc/)
	file(COPY ${GumboParserGit_SOURCE_DIR}/COPYING DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${GumboParserGit_SOURCE_DIR}/THANKS DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(WRITE "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "cmake_minimum_required(VERSION 2.8.7)\n\nadd_library(Gumbo_Parser STATIC\n") 
	
	foreach(gpf ${GumboParserFiles})
		file(RELATIVE_PATH gpf "${GumboParserGit_SOURCE_DIR}/src/" ${gpf})
		file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\t${gpf}\n")
	endforeach()
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\t)\n\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "target_include_directories(Gumbo_Parser PUBLIC \${CMAKE_CURRENT_SOURCE_DIR})\n\nif(MSVC)\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\ttarget_include_directories(Gumbo_Parser PRIVATE \${CMAKE_CURRENT_SOURCE_DIR}/visualc/include/)\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\ttarget_sources(Gumbo_Parser PRIVATE visualc/include/strings.h)\nendif()\n\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "add_library(Gumbo::Parser ALIAS Gumbo_Parser)\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "SET_TARGET_PROPERTIES (Gumbo_Query PROPERTIES FOLDER Gumbo)\n")
		
	
	
	message(STATUS "Gumbo Parser updated")
endif()