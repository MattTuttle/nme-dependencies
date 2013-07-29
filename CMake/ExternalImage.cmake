# Build a local version of zlib and libpng
INCLUDE(ExternalProject)

SET(libpng_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libpng)

SET(libpng_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
    -DPNG_SHARED=OFF
    -DBUILD_SHARED_LIBS=FALSE
    -DSKIP_INSTALL_FILES=1
)

EXTERNALPROJECT_ADD(zlib
    PREFIX ${libpng_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL http://zlib.net/zlib-1.2.8.tar.gz
    URL_MD5 44d667c142d7cda120332623eab69f40

    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${NMEDependencies_SOURCE_DIR}/CMake/zlib.cmake <SOURCE_DIR>/CMakeLists.txt && ${CMAKE_COMMAND} -E remove <SOURCE_DIR>/zconf.h

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${libpng_CMAKE_ARGS}
)

ExternalProject_Get_Property(zlib install_dir)

# Kludge: Shouldn't be necessary if FIND_LIBRARY were working on mingw.
IF (MINGW)
	SET(libpng_CMAKE_ARGS ${libpng_CMAKE_ARGS}
		-DZLIB_LIBRARY=zlib
		-DZLIB_INCLUDE_DIR=${install_dir}/include
	)
ENDIF(MINGW)

EXTERNALPROJECT_ADD(libpng
    DEPENDS zlib
    PREFIX ${libpng_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng15/libpng-1.5.10.tar.gz
    URL_MD5 9e5d864bce8f06751bbd99962ecf4aad

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${libpng_CMAKE_ARGS} -DCMAKE_PREFIX_PATH=${install_dir} # to find zlib
)

SET(libjpeg_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libjpeg)

# Kludge: Shouldn't be necessary if FIND_LIBRARY were working on mingw.
IF (MINGW)
    SET(libjpeg_CMAKE_ARGS ${libjpeg_CMAKE_ARGS}
        -DZLIB_LIBRARY=zlib
        -DZLIB_INCLUDE_DIR=${install_dir}/include
    )
ENDIF(MINGW)

EXTERNALPROJECT_ADD(libjpeg
    DEPENDS zlib
    PREFIX ${libjpeg_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL http://www.ijg.org/files/jpegsrc.v9.tar.gz
    URL_MD5 b397211ddfd506b92cd5e02a22ac924d

    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${NMEDependencies_SOURCE_DIR}/CMake/libjpeg.cmake <SOURCE_DIR>/CMakeLists.txt
    CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${libjpeg_CMAKE_ARGS} -DCMAKE_PREFIX_PATH=${install_dir} # to find zlib
)