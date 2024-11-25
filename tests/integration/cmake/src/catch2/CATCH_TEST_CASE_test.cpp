#define CATCH_CONFIG_PREFIX_ALL

#include <catch2/catch_test_macros.hpp>

namespace my_tests {

CATCH_TEST_CASE("First", "[first]") { CATCH_REQUIRE(true); }

CATCH_TEST_CASE("Second") {
  CATCH_CHECK(false);
  CATCH_REQUIRE(false);
}

} // namespace my_tests
