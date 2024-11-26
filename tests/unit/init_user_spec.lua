local assert = require("luassert")
local adapter = require("neotest-cpp")
local config = require("neotest-cpp.config")

local user_config = {
  root = function(_)
    return true
  end,
  is_test_file = function(_)
    return true
  end,
  filter_dir = function(_)
    return true
  end,
}

adapter.setup(user_config)

describe("adapter.setup", function()
  it("should initialize user config", function()
    local expected_config = user_config
    local actual_config = config.get()
    assert.are.same(expected_config.root, actual_config.root)
    assert.are.same(expected_config.is_test_file, actual_config.is_test_file)
    assert.are.same(expected_config.filter_dir, actual_config.filter_dir)
  end)
end)

describe("adapter.root", function()
  it("should call the user override", function()
    assert.is_true(adapter.root("/foo"))
  end)
end)

describe("adapter.is_test_file", function()
  it("should call the user override", function()
    assert.is_true(adapter.is_test_file("/foo/bar.cc"))
  end)
end)

describe("adapter.filter_dir", function()
  it("should call the user override", function()
    assert.is_true(adapter.filter_dir("build", "", ""))
  end)
end)
