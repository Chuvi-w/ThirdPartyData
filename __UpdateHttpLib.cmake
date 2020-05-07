cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_HttpLib

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()
find_package (Python COMPONENTS Interpreter)

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/CppHttpLibGit/)


git_clone(
        PROJECT_NAME    CppHttpLibGit
        GIT_URL        	https://github.com/yhirose/cpp-httplib.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)


if(CppHttpLibGit_CLONE_RESULT)	
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/httplib.cc)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/httplib.h)
	file(COPY ${CppHttpLibGit_SOURCE_DIR}/LICENSE DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
	if(TRUE)
		PrintVar(Python_EXECUTABLE)
		execute_process(
                  COMMAND ${Python_EXECUTABLE} ${CppHttpLibGit_SOURCE_DIR}/split.py
                  WORKING_DIRECTORY ${CppHttpLibGit_SOURCE_DIR}
                  RESULT_VARIABLE py_result
               )
		file(COPY ${CppHttpLibGit_SOURCE_DIR}/out/httplib.cc DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
		file(COPY ${CppHttpLibGit_SOURCE_DIR}/out/httplib.h DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
	else()
		set(CppHttpLibGitInImplementation FALSE)
		file(TOUCH ${CMAKE_CURRENT_LIST_DIR}/httplib.cc)
		file(TOUCH ${CMAKE_CURRENT_LIST_DIR}/httplib.h)
		file(APPEND  ${CMAKE_CURRENT_LIST_DIR}/httplib.cc "#include \"httplib.h\"\nnamespace httplib {\n")
		file(STRINGS ${CppHttpLibGit_SOURCE_DIR}/httplib.h HttpLibHdr)
		foreach(hvar ${HttpLibHdr})
			if(hvar STREQUAL "// ----------------------------------------------------------------------------")
				if(CppHttpLibGitInImplementation)
					set(CppHttpLibGitInImplementation FALSE)
				else()
					set(CppHttpLibGitInImplementation TRUE)
				endif()
				#PrintVar(CppHttpLibGitInImplementation)
			else()
				if(CppHttpLibGitInImplementation)
					string(REPLACE "inline" "" hvar "${hvar}")
					file(APPEND  ${CMAKE_CURRENT_LIST_DIR}/httplib.cc "${hvar}\n")
				else()
					file(APPEND  ${CMAKE_CURRENT_LIST_DIR}/httplib.h "${hvar}\n")
				endif()
			endif()
			#PrintVar(hvar)
		endforeach()
		file(APPEND  ${CMAKE_CURRENT_LIST_DIR}/httplib.cc "} // namespace httplib\n")
		#file(COPY ${json_dto_git_SOURCE_DIR}/dev/json_dto/pub.hpp DESTINATION ${PROJECT_SOURCE_DIR}/ThirdParty/json_dto/)
		#file(COPY ${json_dto_git_SOURCE_DIR}/dev/json_dto/validators.hpp DESTINATION ${PROJECT_SOURCE_DIR}/ThirdParty/json_dto/)
	endif()
	message(STATUS "CppHttpLib updated")
endif()