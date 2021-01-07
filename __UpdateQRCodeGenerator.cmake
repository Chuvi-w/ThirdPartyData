cmake_minimum_required(VERSION 3.15)
#THIRD_PARTY_UPDATE_SCRIPT SKIP_UPDADE_QRCodeGenerator

if(NOT THIRD_PARTY_GIT_DIR)
 set(THIRD_PARTY_GIT_DIR /_ThirdPartyGit CACHE INTERNAL  FORCE)
endif()

file(REMOVE_RECURSE ${THIRD_PARTY_GIT_DIR}/QRCodeGenGit/)
git_clone(
        PROJECT_NAME    QRCodeGenGit
        GIT_URL         https://github.com/nayuki/QR-Code-generator.git
        GIT_BRANCH      master
		DIRECTORY ${THIRD_PARTY_GIT_DIR}
		QUIET
)

if(QRCodeGenGit_CLONE_RESULT)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/QrCode.cpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/QrCode.hpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/QrCodeGeneratorDemo.cpp)
	file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/QrCodeGeneratorWorker.cpp)
	
	file(COPY ${QRCodeGenGit_SOURCE_DIR}/cpp/QrCode.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${QRCodeGenGit_SOURCE_DIR}/cpp/QrCode.hpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${QRCodeGenGit_SOURCE_DIR}/cpp/QrCodeGeneratorDemo.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	file(COPY ${QRCodeGenGit_SOURCE_DIR}/cpp/QrCodeGeneratorWorker.cpp DESTINATION ${CMAKE_CURRENT_LIST_DIR})
	message(STATUS "QRCodeGenerator updated")
endif()