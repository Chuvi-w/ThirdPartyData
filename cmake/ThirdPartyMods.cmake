cmake_minimum_required(VERSION 3.15)

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
	file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/init_${ModName}/)
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

function(UpdateThirdPartyMods)
	file (GLOB_RECURSE UpdateScripts "${THIRD_PARTY_MOD_DIR}/__Update*.cmake")
		foreach(ScriptFile ${UpdateScripts})
			#message("Src=${SrcFile}")
			file(STRINGS ${ScriptFile} FileStrings)
			foreach(FileStr ${FileStrings})
				string(REGEX MATCH "#THIRD_PARTY_UPDATE_SCRIPT[ \t]+([^\r^\n]+)" RegVar ${FileStr})
				#message("RegVar=${RegVar} |0=${CMAKE_MATCH_0}|1=${CMAKE_MATCH_1}|2=${CMAKE_MATCH_2}")
				if(CMAKE_MATCH_0)
					if(CMAKE_MATCH_1 AND NOT ${CMAKE_MATCH_1})
						include(${ScriptFile})
					endif()
				endif()
			endforeach()
		endforeach()
endfunction()

function(ListThirdPartyModsSkipVars)
	file (GLOB_RECURSE UpdateScripts "${THIRD_PARTY_MOD_DIR}/__Update*.cmake")
		foreach(ScriptFile ${UpdateScripts})
			#message("Src=${SrcFile}")
			file(STRINGS ${ScriptFile} FileStrings)
			foreach(FileStr ${FileStrings})
				string(REGEX MATCH "#THIRD_PARTY_UPDATE_SCRIPT[ \t]+([^\r^\n]+)" RegVar ${FileStr})
				#message("RegVar=${RegVar} |0=${CMAKE_MATCH_0}|1=${CMAKE_MATCH_1}|2=${CMAKE_MATCH_2}")
				if(CMAKE_MATCH_0 AND CMAKE_MATCH_1)
					message("set(${CMAKE_MATCH_1} TRUE)")
				endif()
			endforeach()
		endforeach()
endfunction()
