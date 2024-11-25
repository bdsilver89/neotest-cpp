local assert = require("luassert")
local catch2 = require("neotest-cpp.framework.catch2")
local it = require("nio").tests.it

describe("catch2.parse_positions", function()
  it("discovers TEST_CASE", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/TEST_CASE_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "TEST_CASE_test.cpp",
        path = test_file,
        range = { 0, 0, 12, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "my_tests"),
          name = "my_tests",
          path = test_file,
          range = { 2, 0, 6, 1 },
          type = "namespace",
        },
        {
          {
            id = ("%s::%s::%s"):format(test_file, "my_tests", "First"),
            name = "First",
            path = test_file,
            range = { 4, 0, 4, 48 },
            type = "test",
          },
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Second"),
          name = "Second",
          path = test_file,
          range = { 8, 0, 11, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[2][2][1], actual_positions[2][2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)

  it("discovers CATCH_TEST_CASE", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/CATCH_TEST_CASE_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "CATCH_TEST_CASE_test.cpp",
        path = test_file,
        range = { 0, 0, 14, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "my_tests"),
          name = "my_tests",
          path = test_file,
          range = { 4, 0, 8, 1 },
          type = "namespace",
        },
        {
          {
            id = ("%s::%s::%s"):format(test_file, "my_tests", "First"),
            name = "First",
            path = test_file,
            range = { 6, 0, 6, 60 },
            type = "test",
          },
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Second"),
          name = "Second",
          path = test_file,
          range = { 10, 0, 13, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[2][2][1], actual_positions[2][2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)

  it("discovers TEST_CASE_METHOD", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/TEST_CASE_METHOD_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "TEST_CASE_METHOD_test.cpp",
        path = test_file,
        range = { 0, 0, 10, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "First"),
          name = "First",
          path = test_file,
          range = { 4, 0, 4, 64 },
          type = "test",
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Second"),
          name = "Second",
          path = test_file,
          range = { 6, 0, 9, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)

  it("discovers CATCH_TEST_CASE_METHOD", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/CATCH_TEST_CASE_METHOD_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "CATCH_TEST_CASE_METHOD_test.cpp",
        path = test_file,
        range = { 0, 0, 12, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "First"),
          name = "First",
          path = test_file,
          range = { 6, 0, 6, 76 },
          type = "test",
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Second"),
          name = "Second",
          path = test_file,
          range = { 8, 0, 11, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)

  it("discovers SCENARIO", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/SCENARIO_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "SCENARIO_test.cpp",
        path = test_file,
        range = { 0, 0, 25, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Scenario: First"),
          name = "Scenario: First",
          path = test_file,
          range = { 2, 0, 12, 1 },
          type = "test",
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Scenario: Second"),
          name = "Scenario: Second",
          path = test_file,
          range = { 14, 0, 24, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)

  it("discovers CATCH_SCENARIO", function()
    local test_file = (vim.uv or vim.loop).cwd()
      .. "/tests/unit/data/framework/catch2/CATCH_SCENARIO_test.cpp"
    local actual_positions = catch2.parse_positions(test_file):to_list()
    local expected_positions = {
      {
        id = test_file,
        name = "CATCH_SCENARIO_test.cpp",
        path = test_file,
        range = { 0, 0, 27, 0 },
        type = "file",
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Scenario: First"),
          name = "Scenario: First",
          path = test_file,
          range = { 4, 0, 14, 1 },
          type = "test",
        },
      },
      {
        {
          id = ("%s::%s"):format(test_file, "Scenario: Second"),
          name = "Scenario: Second",
          path = test_file,
          range = { 16, 0, 26, 1 },
          type = "test",
        },
      },
    }

    assert.are.same(expected_positions[1], actual_positions[1])
    assert.are.same(expected_positions[2][1], actual_positions[2][1])
    assert.are.same(expected_positions[3][1], actual_positions[3][1])
  end)
end)

describe("catch2.parse_errors", function()
  it("parses diagnostics correctly", function()
    local output = [[
Randomness seeded to: 1568493961

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
catch2_TEST_CASE_test is a Catch2 v3.6.0 host application.
Run with -? for options

-------------------------------------------------------------------------------
Second
-------------------------------------------------------------------------------
/path/to/TEST_CASE_test.cpp:7
...............................................................................

/path/to/TEST_CASE_test.cpp:8: FAILED:
  CHECK( false )

/path/to/TEST_CASE_test.cpp:9: FAILED:
  REQUIRE( false )

===============================================================================
test cases: 1 | 1 failed
assertions: 2 | 2 failed
]]

    local actual_errors = catch2.parse_errors(output)
    local expected_errors = {
      {
        line = 8,
        message = "  CHECK( false )",
      },
      {
        line = 9,
        message = "  REQUIRE( false )",
      },
    }

    assert.are.same(expected_errors, actual_errors)
  end)

  it("parses prefix diagnostics correctly", function()
    local output = [[
Randomness seeded to: 1763123953

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
catch2_CATCH_TEST_CASE_test is a Catch2 v3.6.0 host application.
Run with -? for options

-------------------------------------------------------------------------------
Second
-------------------------------------------------------------------------------
/path/to/CATCH_TEST_CASE_test.cpp:9
...............................................................................

/path/to/CATCH_TEST_CASE_test.cpp:10: FAILED:
  CATCH_CHECK( false )

/path/to/CATCH_TEST_CASE_test.cpp:11: FAILED:
  CATCH_REQUIRE( false )

===============================================================================
test cases: 1 | 1 failed
assertions: 2 | 2 failed
]]

    local actual_errors = catch2.parse_errors(output)
    local expected_errors = {
      {
        line = 10,
        message = "  CATCH_CHECK( false )",
      },
      {
        line = 11,
        message = "  CATCH_REQUIRE( false )",
      },
    }

    assert.are.same(expected_errors, actual_errors)
  end)
end)
