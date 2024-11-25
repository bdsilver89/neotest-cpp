#include <catch2/catch_test_macros.hpp>

namespace my_tests {

TEST_CASE("First", "[first]") { REQUIRE(true); }

TEST_CASE("Second") {
  CHECK(false);
  REQUIRE(false);
}

} // namespace my_tests
