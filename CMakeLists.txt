cmake_minimum_required( VERSION 2.8 )

project(ThirdPartyUtils)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake/")
include(${CMAKE_CURRENT_LIST_DIR}/ThirdParty/GitUtils/GitUtils.cmake)
include(ThirdPartyMods)

#AddThirdPartyMod(GitUtils)
#AddThirdPartyMod(ucm)
#AddThirdPartyMod(cotire)
#set(SKIP_UPDADE_COTIRE TRUE)
ListThirdPartyModsSkipVars()
UpdateThirdPartyMods()
