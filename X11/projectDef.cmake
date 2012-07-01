##
# Linphone Web - Web plugin of Linphone an audio/video SIP phone
# Copyright (C) 2012  Yann Diorcet <yann.diorcet@linphone.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
##

# X11 template platform definition CMake file
# Included from ../CMakeLists.txt
include(${CMAKE_CURRENT_SOURCE_DIR}/Common/common.cmake)

# remember that the current source dir is the project root; this file is in X11/
file (GLOB PLATFORM RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    X11/[^.]*.cpp
    X11/[^.]*.h
    X11/[^.]*.cmake
    )

# GCC options
add_definitions(-std=c++0x)

include_directories(Rootfs/include/linphone)
include_directories(Rootfs/include)

SOURCE_GROUP(X11 FILES ${PLATFORM})

set (SOURCES
    ${SOURCES}
    ${PLATFORM}
    )

add_x11_plugin(${PROJECT_NAME} SOURCES)

# Add library dependencies here; leave ${PLUGIN_INTERNAL_DEPS} there unless you know what you're doing!
target_link_libraries(${PROJECT_NAME} 
	${PLUGIN_INTERNAL_DEPS}
	"${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/liblinphone.so.5"
	"${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libmediastreamer.so.1"
	"${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libortp.so.8"
)

SET (LINPHONEWEB_SHAREDIR linphoneweb)
SET (FB_OUT_DIR ${FB_BIN_DIR}/${PLUGIN_NAME}/${CMAKE_CFG_INTDIR})

# Copy dll dependencies
ADD_CUSTOM_COMMAND(TARGET ${PROJECT_NAME} 
		  PRE_BUILD
		  COMMAND ${CMAKE_COMMAND} -E make_directory ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libavcodec.so.53 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libavutil.so.51 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libcrypto.so.1.0.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libeXosip2.so.7 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libjpeg.so.8 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/liblinphone.so.5 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libmediastreamer.so.1 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libogg.so.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libortp.so.8 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libosip2.so.7 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libosipparser2.so.7 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libspeex.so.1 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libspeexdsp.so.1 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libssl.so.1.0.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
          COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libswscale.so.2 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libtheora.so.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libv4l1.so.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libv4l2.so.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libv4lconvert.so.0 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libvpx.so.1 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/lib/libz.so.1 ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/

		  COMMAND ${CMAKE_COMMAND} -E make_directory ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/
		  COMMAND ${CMAKE_COMMAND} -E make_directory ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/
		  COMMAND ${CMAKE_COMMAND} -E make_directory ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/
		  COMMAND ${CMAKE_COMMAND} -E make_directory ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/share/sounds/linphone/ringback.wav ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/
		  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Rootfs/share/sounds/linphone/rings/oldphone.wav ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/
)

# Use default chrpath if not defined
IF(NOT DEFINED CMAKE_CHRPATH)
	SET(CMAKE_CHRPATH chrpath)
ENDIF(NOT DEFINED CMAKE_CHRPATH)

# Change rpath
ADD_CUSTOM_COMMAND(TARGET ${PROJECT_NAME} 
                 PRE_BUILD
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavcodec.so.53
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavutil.so.51
#                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libcrypto.so.1.0.0                 
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libjpeg.so.8
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libeXosip2.so.7
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/liblinphone.so.5
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libmediastreamer.so.1           
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libogg.so.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libortp.so.8
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosip2.so.7
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosipparser2.so.7
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeex.so.1
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeexdsp.so.1
#                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libssl.so.1.0.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libswscale.so.2
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libtheora.so.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l1.so.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l2.so.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4lconvert.so.0
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libvpx.so.1
                 COMMAND ${CMAKE_CHRPATH} -c -r \\\$$ORIGIN ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libz.so.1
)

# Add rpath to generated library
SET (CMAKE_SHARED_LINKER_FLAGS
    "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-rpath,'\$ORIGIN/${LINPHONEWEB_SHAREDIR}'" )


###############################################################################
# XPI Package

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/X11/XPI/install.rdf ${CMAKE_CURRENT_BINARY_DIR}/install.rdf)
INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/install.rdf DESTINATION . COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(TARGETS ${PROJECT_NAME} DESTINATION plugins COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${CMAKE_CURRENT_SOURCE_DIR}/X11/XPI/chrome.manifest DESTINATION . COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${CMAKE_CURRENT_SOURCE_DIR}/X11/XPI/chrome/skin/icon64.png DESTINATION chrome/skin COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${CMAKE_CURRENT_SOURCE_DIR}/X11/XPI/chrome/skin/icon.png DESTINATION chrome/skin COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavcodec.so.53 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavutil.so.51 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libcrypto.so.1.0.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libjpeg.so.8 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libeXosip2.so.7 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/liblinphone.so.5 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libmediastreamer.so.1 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libogg.so.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libortp.so.8 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosip2.so.7 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosipparser2.so.7 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeex.so.1 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeexdsp.so.1 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libssl.so.1.0.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libswscale.so.2 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libtheora.so.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l1.so.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l2.so.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4lconvert.so.0 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libvpx.so.1 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libz.so.1 DESTINATION plugins/${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-XPI)

INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/ringback.wav DESTINATION plugins/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/ COMPONENT ${PROJECT_NAME}-XPI)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/oldphone.wav DESTINATION plugins/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/ COMPONENT ${PROJECT_NAME}-XPI)


SET(CPACK_PACKAGE_NAME ${PROJECT_NAME})
SET(CPACK_PACKAGE_VERSION ${FBSTRING_PLUGIN_VERSION})
SET(CPACK_GENERATOR ZIP)
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
SET(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_SOURCE_DIR}/build;${CMAKE_PROJECT_NAME};${PROJECT_NAME}-XPI;/") 
create_cpack_config(${PROJECT_NAME}-XPI.cmake)
###############################################################################


###############################################################################
# TGZ Package
INSTALL(TARGETS ${PROJECT_NAME} DESTINATION . COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavcodec.so.53 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libavutil.so.51 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libcrypto.so.1.0.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libjpeg.so.8 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libeXosip2.so.7 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/liblinphone.so.5 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libmediastreamer.so.1 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libogg.so.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libortp.so.8 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosip2.so.7 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libosipparser2.so.7 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeex.so.1 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libspeexdsp.so.1 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libssl.so.1.0.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libswscale.so.2 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libtheora.so.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l1.so.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4l2.so.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libv4lconvert.so.0 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libvpx.so.1 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/libz.so.1 DESTINATION ${LINPHONEWEB_SHAREDIR} COMPONENT ${PROJECT_NAME}-TGZ)

INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/ringback.wav DESTINATION ${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/ COMPONENT ${PROJECT_NAME}-TGZ)
INSTALL(FILES ${FB_OUT_DIR}/${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/oldphone.wav DESTINATION ${LINPHONEWEB_SHAREDIR}/share/sounds/linphone/rings/ COMPONENT ${PROJECT_NAME}-TGZ)

SET(CPACK_PACKAGE_NAME ${PROJECT_NAME})
SET(CPACK_PACKAGE_VERSION ${FBSTRING_PLUGIN_VERSION})
SET(CPACK_GENERATOR TGZ)
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY ON)
SET(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_SOURCE_DIR}/build;${CMAKE_PROJECT_NAME};${PROJECT_NAME}-TGZ;/") 
create_cpack_config(${PROJECT_NAME}-TGZ.cmake)
###############################################################################


# Create packages
ADD_CUSTOM_COMMAND(TARGET ${PROJECT_NAME} 
                 POST_BUILD
                 COMMAND cpack --config ${PROJECT_NAME}-TGZ.cmake
		 COMMAND ${CMAKE_COMMAND} -E rename ${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux.tar.gz ${FB_OUT_DIR}/${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux.tar.gz
                 COMMAND cpack --config ${PROJECT_NAME}-XPI.cmake
		 COMMAND ${CMAKE_COMMAND} -E rename ${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux.zip ${FB_OUT_DIR}/${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux-unsigned.xpi
)

create_signed_xpi(${PLUGIN_NAME} 
	"${FB_OUT_DIR}/${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux-unsigned.xpi"
	"${FB_OUT_DIR}/${PROJECT_NAME}-${FBSTRING_PLUGIN_VERSION}-Linux.xpi"
	"${CMAKE_CURRENT_SOURCE_DIR}/sign/linphoneweb.pem"
	"${CMAKE_CURRENT_SOURCE_DIR}/sign/passphrase.txt"
)
