# Build a local version of curl
INCLUDE(ExternalProject)

SET(curl_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/curl)

SET(curl_CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
	-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES}
)

EXTERNALPROJECT_ADD(curl
    PREFIX ${curl_PREFIX}

    DOWNLOAD_DIR ${NME_DEPS_DOWNLOAD_DIR}
    URL http://curl.haxx.se/download/curl-7.31.0.tar.gz
    URL_MD5 6f26843f7e3a2fb06e02f68a55efe8c7

    INSTALL_DIR ${NME_DEPS_CORE_PREFIX}
    CMAKE_ARGS ${curl_CMAKE_ARGS} -DCMAKE_PREFIX_PATH=${install_dir}
)