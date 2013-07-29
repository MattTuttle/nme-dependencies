# Build a local version of freetype
INCLUDE(ExternalProject)

SET(glfw_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/glfw)

SET(glfw_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
)

EXTERNALPROJECT_ADD(glfw
    PREFIX ${glfw_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    # GIT_REPOSITORY https://github.com/glfw/glfw
    # GIT_TAG 3.0.1
    URL https://github.com/glfw/glfw/archive/3.0.1.tar.gz
    URL_MD5 6ae8ee791232d3b9ad302594560b074b

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${glfw_CMAKE_ARGS} -DCMAKE_PREFIX_PATH=${install_dir}
)