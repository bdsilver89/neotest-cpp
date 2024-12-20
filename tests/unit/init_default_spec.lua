local assert = require("luassert")
local adapter = require("neotest-cpp")
local config = require("neotest-cpp.config")

adapter.setup({})

describe("adapter.setup", function()
  it("should initialize default config", function()
    local expected_config = config.default()
    local actual_config = config.get()
    assert.are.same(expected_config, actual_config)
  end)
end)

describe("adapter.name", function()
  it("should match neotest-cpp", function()
    assert.are.same("neotest-cpp", adapter.name)
  end)
end)

describe("adapter.is_test_file", function()
  it("should return true for default pattern", function()
    assert.is_true(adapter.is_test_file("/foo/bar_test.cc"))
    assert.is_true(adapter.is_test_file("/foo/bar_test.cxx"))
    assert.is_true(adapter.is_test_file("/foo/bar_test.cpp"))
  end)

  it("should return false for ordinary files", function()
    assert.is_false(adapter.is_test_file("/foo/bar.cpp"))
    assert.is_false(adapter.is_test_file("/foo/CMakeLists.txt"))
    assert.is_false(adapter.is_test_file("/foo/baz"))
  end)
end)

describe("adapter.filter_dir", function()
  it("should filter default directories", function()
    assert.is_false(adapter.filter_dir("build", "", ""))
    assert.is_false(adapter.filter_dir("cmake", "", ""))
    assert.is_false(adapter.filter_dir("doc", "", ""))
    assert.is_false(adapter.filter_dir("docs", "", ""))
    assert.is_false(adapter.filter_dir("examples", "", ""))
    assert.is_false(adapter.filter_dir("out", "", ""))
    assert.is_false(adapter.filter_dir("scripts", "", ""))
    assert.is_false(adapter.filter_dir("tools", "", ""))
    assert.is_false(adapter.filter_dir("venv", "", ""))
  end)

  it("should not filter default directories", function()
    assert.is_true(adapter.filter_dir("src", "", ""))
    assert.is_true(adapter.filter_dir("tests", "", ""))
  end)
end)
