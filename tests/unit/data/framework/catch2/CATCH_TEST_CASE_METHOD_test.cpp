#define CATCH_CONFIG_PREFIX_ALL

#include <catch2/catch_test_macros.hpp>

class Fixture {};

CATCH_TEST_CASE_METHOD(Fixture, "First", "[first]") { CATCH_REQUIRE(true); }

CATCH_TEST_CASE_METHOD(Fixture, "Second") {
  CATCH_CHECK(false);
  CATCH_REQUIRE(true);
}
