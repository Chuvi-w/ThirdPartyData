cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_RapidJSON

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/RapidJSONGit/)
git_clone(
        PROJECT_NAME    RapidJSONGit
        GIT_URL         https://github.com/Tencent/rapidjson.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(RapidJSONGit_CLONE_RESULT)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/include)
	file(COPY ${RapidJSONGit_SOURCE_DIR}/include DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
	file(COPY ${RapidJSONGit_SOURCE_DIR}/license.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "RapidJSON updated")
endif()