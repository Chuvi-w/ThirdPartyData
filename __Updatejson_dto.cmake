cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_json_dto

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()


file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/json_dto_git/)

git_clone(
        PROJECT_NAME    json_dto_git
        GIT_URL         https://github.com/Stiffstream/json_dto.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(json_dto_git_CLONE_RESULT)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/pub.hpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/validators.hpp)
	file(COPY ${json_dto_git_SOURCE_DIR}/dev/json_dto/pub.hpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${json_dto_git_SOURCE_DIR}/dev/json_dto/validators.hpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${json_dto_git_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${json_dto_git_SOURCE_DIR}/THANKS DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "json_dto updated")
endif()