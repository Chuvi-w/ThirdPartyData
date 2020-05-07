cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_clip

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/ClipGit/)
git_clone(
        PROJECT_NAME    ClipGit
        GIT_URL         https://github.com/dacap/clip.git
        GIT_BRANCH      master
        DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(ClipGit_CLONE_RESULT)
    file(GLOB CLipFiles ${ClipGit_SOURCE_DIR}/*.h ${ClipGit_SOURCE_DIR}/*.cpp ${ClipGit_SOURCE_DIR}/*.mm)
    file(COPY ${ClipGit_SOURCE_DIR}/LICENSE.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
    file(COPY ${CLipFiles} DESTINATION ${CMAKE_CURRENT_LIST_DIR}/)
    file(READ ${ClipGit_SOURCE_DIR}/CMakeLists.txt ClipCMakeText)
    string(REPLACE "if(CLIP_EXAMPLES)" "if(FALSE)#CLIP_EXAMPLES" ClipCMakeText "${ClipCMakeText}")
    string(REPLACE "if(CLIP_TESTS)" "if(FALSE)#CLIP_TESTS" ClipCMakeText "${ClipCMakeText}")
    file(WRITE ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt "${ClipCMakeText}")
	file(APPEND ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt "\ntarget_include_directories(clip PUBLIC \${CMAKE_CURRENT_SOURCE_DIR})")
	message(STATUS "CLip updated")
endif()