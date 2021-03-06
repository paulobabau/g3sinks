# =====================================================
#  Public Domain: Inspired by github.com/KjellKod/g3log/CMakeLists.cmake
#  2015, April 30, @author Kjell.Hedstrom
# =====================================================

option (ADD_LOGROTATE_UNIT_TEST "logrotate unit tests" OFF)

IF (ADD_LOGROTATE_UNIT_TEST)

    set(GTEST_DIR ${DIR_3RDPARTY}/gtest-1.7.0)
    set(GTEST_INCLUDE_DIRECTORIES ${GTEST_DIR}/include ${GTEST_DIR} ${GTEST_DIR}/src)
    MESSAGE( "Attempt to build gtest. gtest directory: " ${GTEST_DIR})
    include_directories(${GTEST_INCLUDE_DIRECTORIES})
    add_library(gtest_170_lib ${GTEST_DIR}/src/gtest-all.cc)
    set_target_properties(gtest_170_lib PROPERTIES COMPILE_DEFINITIONS "GTEST_HAS_RTTI=0")
    enable_testing(true)
    include_directories(test)
    file(GLOB TEST_SRC_FILES "test/*.cpp" "test/*.h" "test/*.hpp")
    set(TestRunner UnitTestRunner)

    # build the unit tests   
    add_executable(${TestRunner} ${DIR_3RDPARTY}/test_main.cpp ${TEST_SRC_FILES} )
    set_target_properties(${TestRunner} PROPERTIES COMPILE_DEFINITIONS "GTEST_HAS_TR1_TUPLE=0")
    set_target_properties(${TestRunner} PROPERTIES COMPILE_DEFINITIONS "GTEST_HAS_RTTI=0")
    set_target_properties(${TestRunner} PROPERTIES COMPILE_FLAGS "-isystem -pthread ")
    target_link_libraries(${TestRunner} ${LIBRARY_TO_BUILD} ${G3LOG} gtest_170_lib -lstdc++ ${TCMALLOC}  ${PLATFORM_LINK_LIBRIES} -Wl,-rpath,. -Wl,-rpath,${G3_LIBRARY_PATH}  -Wl,-rpath,${G3_LIBRARY_PATH}/../lib64 )

    MESSAGE("library to build ${LIBRARY_TO_BUILD}")

ELSE() 
  MESSAGE("-DADD_LOGROTATE_UNIT_TEST=OFF") 
ENDIF (ADD_LOGROTATE_UNIT_TEST)
