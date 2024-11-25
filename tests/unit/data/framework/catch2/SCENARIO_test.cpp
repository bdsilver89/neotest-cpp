#include <catch2/catch_test_macro.hpp>

SCENARIO("First") {
  GIVEN("A counter starting at zero") {
    int v = 0;

    WHEN("Incremented by 1") {
      v += 1;

      THEN("The value should equal 1") { REQUIRE(v == 1); }
    }
  }
}

SCENARIO("Second") {
  GIVEN("A counter starting at zero") {
    int v = 0;

    WHEN("Incremented by 2") {
      v += 2;

      THEN("The value should equal 2") { REQUIRE(v == 2); }
    }
  }
}
