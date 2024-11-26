local assert = require("luassert")
local it = require("nio.tests").it
local before_each = require("nio.tests").before_each
local Path = require("plenary.path")

describe("with project root", function()
  local example_root, ctest

  before_each(function()
    local cwd = (vim.uv or vim.loop).cwd()
    example_root = cwd .. "/tests/integration/cmake"
    ctest = require("neotest-cpp.provider.ctest"):new(example_root)
  end)

  it("should find CTest test directory", function()
    local expected_test_dir = Path:new(example_root, "build"):absolute()
    assert.equals(expected_test_dir, ctest._test_dir)
  end)

  it("should find CTest tests", function()
    local testcases = ctest:testcases()
    local num_testcases = #vim.tbl_keys(testcases)
    assert.is_true(num_testcases > 0)
  end)
end)
