CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

PROJECT(libtheora C)

IF(NOT CMAKE_BUILD_TYPE)
    #SET(CMAKE_BUILD_TYPE "Debug")
    SET(CMAKE_BUILD_TYPE "Release")
    MESSAGE("No CMAKE_BUILD_TYPE specified, defaulting to ${CMAKE_BUILD_TYPE}")
ENDIF(NOT CMAKE_BUILD_TYPE)

# to distinguish between debug and release lib
SET(CMAKE_DEBUG_POSTFIX "d")

FIND_PATH(OGG_INCLUDE_DIR NAMES ogg/ogg.h)

FIND_LIBRARY(OGG_RELEASE_LIBRARY NAMES libogg)
FIND_LIBRARY(OGG_DEBUG_LIBRARY NAMES liboggd)

IF(OGG_DEBUG_LIBRARY)
    LIST(APPEND OGG_LIBRARY debug ${OGG_DEBUG_LIBRARY})
ENDIF(OGG_DEBUG_LIBRARY)
IF(OGG_RELEASE_LIBRARY)
    LIST(APPEND OGG_LIBRARY  optimized ${OGG_RELEASE_LIBRARY})
ENDIF(OGG_RELEASE_LIBRARY)

MESSAGE("CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}")
MESSAGE("OGG_LIBRARY=${OGG_LIBRARY}")

SET(libtheora_SRCS
    lib/analyze.c
    lib/apiwrapper.c
    lib/bitpack.c
    lib/cpu.c
    lib/decapiwrapper.c
    lib/decinfo.c
    lib/decode.c
    lib/dequant.c
    lib/encapiwrapper.c
    lib/encfrag.c
    lib/encinfo.c
    lib/encode.c
    lib/encoder_disabled.c
    lib/enquant.c
    lib/fdct.c
    lib/fragment.c
    lib/huffdec.c
    lib/huffenc.c
    lib/idct.c
    lib/info.c
    lib/internal.c
    lib/mathops.c
    lib/mcenc.c
    lib/quant.c
    lib/rate.c
    lib/state.c
    lib/tokenize.c
)

SET(libtheora_HDRS
    lib/apiwrapper.h
    lib/bitpack.h
    lib/cpu.h
    lib/dct.h
    lib/decint.h
    lib/dequant.h
    lib/encint.h
    lib/enquant.h
    lib/huffdec.h
    lib/huffenc.h
    lib/huffman.h
    lib/internal.h
    lib/mathops.h
    lib/modedec.h
    lib/ocintrin.h
    lib/quant.h
)

SET(theora_public_HDRS
    include/theora/codec.h
    include/theora/theora.h
    include/theora/theoradec.h
    include/theora/theoraenc.h
)

INCLUDE_DIRECTORIES(${OGG_INCLUDE_DIR} include lib)

IF(MSVC)
    ADD_DEFINITIONS(/D_UNICODE /DUNICODE)
    LIST(APPEND libtheora_SRCS win32/theora.def)
ENDIF(MSVC)

ADD_LIBRARY(libtheora ${libtheora_SRCS} ${libtheora_HDRS} ${theora_public_HDRS})

INSTALL(TARGETS
    libtheora #libtheora_dynamic
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib)

INSTALL(FILES ${theora_public_HDRS} DESTINATION include/theora)