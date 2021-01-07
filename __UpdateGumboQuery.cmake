cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_GumboQuery

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/GumboQueryGit/)
git_clone(
        PROJECT_NAME    GumboQueryGit
        GIT_URL        	https://github.com/lazytiger/gumbo-query.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(GumboQueryGit_CLONE_RESULT)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/*.cpp ${CMAKE_CURRENT_LIST_DIR}/*.h)
	file(GLOB GumboQueryFiles ${GumboQueryGit_SOURCE_DIR}/src/*.h ${GumboQueryGit_SOURCE_DIR}/src/*.cpp)
	file(COPY ${GumboQueryFiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
	file(COPY ${GumboQueryGit_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(WRITE "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "cmake_minimum_required(VERSION 3.15)\n\nadd_library(Gumbo_Query STATIC\n") 
	
	foreach(gpf ${GumboQueryFiles})
		file(RELATIVE_PATH gpf "${GumboQueryGit_SOURCE_DIR}/src/" ${gpf})
		file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\t${gpf}\n")
	endforeach()
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "\t)\n\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "target_include_directories(Gumbo_Query PUBLIC \${CMAKE_CURRENT_SOURCE_DIR})\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "target_link_libraries(Gumbo_Query PUBLIC Gumbo_Parser)\n")
	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "add_library(Gumbo::Query ALIAS Gumbo_Query)\n")

	file(APPEND "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" "SET_TARGET_PROPERTIES (Gumbo_Query PROPERTIES FOLDER Gumbo)\n")
	message(STATUS "Gumbo Query updated")
endif()