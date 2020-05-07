cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_md4c

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/md4c_git/)
git_clone(
        PROJECT_NAME    md4c_git
        GIT_URL         https://github.com/mity/md4c.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(md4c_git_CLONE_RESULT)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/src/)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/md2html/)
	file(GLOB  MD4CFiles ${md4c_git_SOURCE_DIR}/src/*.h ${md4c_git_SOURCE_DIR}/src/*.c )
	file(GLOB  MD2HTMLiles ${md4c_git_SOURCE_DIR}/md2html/*.h ${md4c_git_SOURCE_DIR}/md2html/*.c)
	
	message("MD4CFiles=${MD4CFiles}")
	message("MD2HTMLiles=${MD2HTMLiles}")
	file(COPY ${md4c_git_SOURCE_DIR}/LICENSE.md DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${MD4CFiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR}/src)
	file(COPY ${MD2HTMLiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR}/md2html)
	#file(REMOVE 	${CMAKE_CURRENT_LIST_DIR}/LICENSE.md)
    #file(COPY ${md4c_git_SOURCE_DIR}/LICENSE.md DESTINATION ${CMAKE_CURRENT_LIST_DIR})
    #file(COPY ${md4c_git_SOURCE_DIR}/md4c DESTINATION ${CMAKE_CURRENT_LIST_DIR})
    #file(COPY ${md4c_git_SOURCE_DIR}/md2html DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "md4c updated")
endif()