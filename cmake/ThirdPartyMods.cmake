cmake_minimum_required(VERSION 3.10)

if(NOT COMMAND git_clone)
	message(FATAL_ERROR "git_clone command not exist")
endif()

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR ${CMAKE_BINARY_DIR}/_ThirdPartyGit CACHE INTERNAL "" FORCE)
endif()

if(NOT THIRD_PARTY_MOD_DIR)
 set(THIRD_PARTY_MOD_DIR ${PROJECT_SOURCE_DIR}/ThirdParty CACHE INTERNAL "" FORCE)
endif()


function(AddThirdPartyMod ModName)
	git_clone(
			PROJECT_NAME    init_${ModName}
			GIT_URL         https://github.com/Chuvi-w/ThirdPartyData.git
			GIT_BRANCH      ${ModName}
			DIRECTORY ${THIRD_PARTY_GIT_DIR}
			QUIET
	)

	if(init_${ModName}_CLONE_RESULT)
		file (GLOB_RECURSE ${ModName}_Files "${init_${ModName}_SOURCE_DIR}/*")
		list(FILTER ${ModName}_Files EXCLUDE REGEX "${init_${ModName}_SOURCE_DIR}/.git/")
		#message(STATUS "init_${ModName}_SOURCE_DIR==${init_${ModName}_SOURCE_DIR}")
		#foreach(SrcFile ${${ModName}_Files})
		#	message("Src=${SrcFile}")
		#endforeach()
		file(REMOVE_RECURSE ${THIRD_PARTY_MOD_DIR}/${ModName})
		file(COPY ${${ModName}_Files} DESTINATION ${THIRD_PARTY_MOD_DIR}/${ModName})
		message(STATUS "${ModName} Init OK")
	endif()
endfunction()
