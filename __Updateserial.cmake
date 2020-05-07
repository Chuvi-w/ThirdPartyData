cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_serial

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/Serial/)

git_clone(
        PROJECT_NAME    Serial
        GIT_URL        	https://github.com/wjwwood/serial.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(Serial_CLONE_RESULT)
	
	message(STATUS "Serial updated")
endif()