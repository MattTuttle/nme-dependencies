# Build a local version of freetype
INCLUDE(ExternalProject)

SET(freetype_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/freetype)

SET(freetype_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
)

EXTERNALPROJECT_ADD(freetype
    PREFIX ${freetype_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL http://download.savannah.gnu.org/releases/freetype/freetype-2.4.5.tar.gz
    URL_MD5 0e67460b312df905dc1cc1586690e7b2

    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${NMEDependencies_SOURCE_DIR}/CMake/freetype.cmake <SOURCE_DIR>/CMakeLists.txt

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${freetype_CMAKE_ARGS}
)