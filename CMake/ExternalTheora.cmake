# Build a local version of libogg, and libtheora
INCLUDE(ExternalProject)

SET(theora_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/theora)

SET(theora_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
)

EXTERNALPROJECT_ADD(libtheora
    DEPENDS libogg
    PREFIX ${theora_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.gz
    URL_MD5 bb4dc37f0dc97db98333e7160bfbb52b

    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${NMEDependencies_SOURCE_DIR}/CMake/libtheora.cmake <SOURCE_DIR>/CMakeLists.txt

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${theora_CMAKE_ARGS} -DCMAKE_PREFIX_PATH=${install_dir} # to find libogg
)