include(FetchContent)
FetchContent_Declare(
  catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v3.6.0
)
FetchContent_MakeAvailable(catch2)

list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
include(Catch)

add_executable(catch2_TEST_CASE_test TEST_CASE_test.cpp)
target_compile_features(catch2_TEST_CASE_test PRIVATE cxx_std_17)
target_link_libraries(catch2_TEST_CASE_test PRIVATE Catch2::Catch2WithMain)


add_executable(catch2_CATCH_TEST_CASE_test CATCH_TEST_CASE_test.cpp)
target_compile_features(catch2_CATCH_TEST_CASE_test PRIVATE cxx_std_17)
target_link_libraries(catch2_CATCH_TEST_CASE_test PRIVATE Catch2::Catch2WithMain)


catch_discover_tests(catch2_TEST_CASE_test)
