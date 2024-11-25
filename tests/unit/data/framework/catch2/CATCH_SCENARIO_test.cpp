#define CATCH_CONFIG_PREFIX_ALL

#include <catch2/catch_test_macro.hpp>

CATCH_SCENARIO("First") {
  CATCH_GIVEN("A counter starting at zero") {
    int v = 0;

    CATCH_WHEN("Incremented by 1") {
      v += 1;

      CATCH_THEN("The value should equal 1") { CATCH_REQUIRE(v == 1); }
    }
  }
}

CATCH_SCENARIO("Second") {
  CATCH_GIVEN("A counter starting at zero") {
    int v = 0;

    CATCH_WHEN("Incremented by 2") {
      v += 2;

      CATCH_THEN("The value should equal 2") { CATCH_REQUIRE(v == 2); }
    }
  }
}
