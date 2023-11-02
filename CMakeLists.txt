cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

PROJECT(crypto)

set(build_types Debug Release RelWithDebInfo MinSizeRel)
if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "You can choose the type of build, options are:${build_types}")
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
        "Options are ${build_types}"
        FORCE
    )

    # Provide drop down menu options in cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${build_types})
endif()

message(STATUS "Doing a ${CMAKE_BUILD_TYPE} build")
SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-Wno-class-memaccess")
SET(CMAKE_CXX_FLAGS_DEBUG "-Wno-class-memaccess -O1")
SET(CMAKE_CXX_FLAGS_RELEASE "-Wno-class-memaccess -O3 -g0 -fno-exceptions -DNDEBUG -mtune=native -fomit-frame-pointer")
    
add_definitions( -DUSE_POOLS )

option(STATICCOMPILE "Compile to static executable" OFF)
if (STATICCOMPILE)
    set(BUILD_SHARED_LIBS OFF)
endif()

find_package( ZLIB )
link_directories( ${ZLIB_LIBRARY} )
include_directories( ${ZLIB_INCLUDE_DIR} )

add_subdirectory(Solver)
add_custom_target(copy ALL
    COMMENT "Copying binaries from subdirs to build directory")

add_custom_command(
    TARGET copy
    COMMAND ${CMAKE_COMMAND} -E copy Solver/cryptominisat .
)

add_dependencies(copy cryptominisat)
