cmake_minimum_required(VERSION 2.8.7)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_CImg

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()


git_clone(
        PROJECT_NAME    CImgGit
        GIT_URL         https://github.com/dtschump/CImg.git
        GIT_BRANCH      develop
        DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)
set(CIMG_SrcDir "${PROJECT_SOURCE_DIR}/ThirdParty/CImg")
if(CImgGit_CLONE_RESULT)
    file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/CImg.h)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/Licence_CeCILL_V2-en.txt)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/Licence_CeCILL-C_V1-en.txt)
	file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/plugins)
	file(GLOB CimgPlugins ${CImgGit_SOURCE_DIR}/plugins/*.h)
	list(FILTER CimgPlugins EXCLUDE REGEX ".*loop_macros.h$")
	#message("CimgPlugins=${CimgPlugins}")
	file(COPY ${CImgGit_SOURCE_DIR}/CImg.h DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${CImgGit_SOURCE_DIR}/Licence_CeCILL_V2-en.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${CImgGit_SOURCE_DIR}/Licence_CeCILL-C_V1-en.txt DESTINATION ${CMAKE_CURRENT_LIST_DIR})
    file(COPY ${CimgPlugins}/ DESTINATION ${CMAKE_CURRENT_LIST_DIR}/plugins/)
	message(STATUS "CImg updated")
endif()