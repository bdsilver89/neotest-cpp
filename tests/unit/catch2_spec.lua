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
end)
