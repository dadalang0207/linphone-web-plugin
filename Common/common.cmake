#Common cmake function

function(create_cpack_config filename)
	SET(CPACK_OUTPUT_CONFIG_FILE "${filename}")
	INCLUDE(CPack)
endfunction(create_cpack_config)

function (create_signed_xpi PROJNAME IN_FILE OUT_FILE PEMFILE PASSFILE)
    set (WIX_SOURCES
            ${FB_ROOT}/cmake/dummy.cpp
        )
		
	if (NOT FB_XPI_SUFFIX)
		set (FB_XPI_SUFFIX _Xpi)
	endif()
	ADD_LIBRARY(${PROJNAME}${FB_XPI_SUFFIX} STATIC ${WIX_SOURCES})
	if (EXISTS ${PEMFILE})
		ADD_CUSTOM_COMMAND(TARGET ${PROJNAME}${FB_XPI_SUFFIX}
					POST_BUILD
					COMMAND python ${CMAKE_CURRENT_SOURCE_DIR}/Common/xpisign.py -f -k ${PEMFILE} -a ${PASSFILE} ${IN_FILE} ${OUT_FILE}
		)
	else()
		message("-- No signtool certificate found; assuming development machine (${PEMFILE})")
	endif()
	ADD_DEPENDENCIES(${PROJNAME}${FB_XPI_SUFFIX} ${PROJNAME})
	message("-- Successfully added Sign XPI step")
endfunction(create_signed_xpi)

