local assert = require("luassert")
local stub = require("luassert.stub")
local ctest = require("neotest-cpp.provider.ctest")
local it = require("nio").tests.it

describe("ctest:new", function()
  local cwd = "/path/to/project"
  local tempfile = "tempfile"
  local scandir = require("plenary.scandir")
  local lib = require("neotest.lib")
  local fn = require("nio").fn

  it("should return a valid object", function()
    stub(scandir, "scan_dir", function(_, _)
      return { cwd .. "/CTestTestfiles.cmake" }
    end)
    stub(lib.files, "parent", function(_, _)
      return cwd
    end)
    stub(ctest, "run", function(_, _)
      return "3.21.0"
    end)
    stub(fn, "tempname", function(_, _)
      return tempfile
    end)

    local ctest_object = ctest:new(cwd)
    assert.equals(cwd, ctest_object._test_dir)
    assert.equals(tempfile, ctest_object._output_junit_path)
    assert.equals(tempfile, ctest_object._output_log_path)
  end)

  it("should throw error if not test directory is found", function()
    stub(scandir, "scan_dir", function(_, _)
      return {}
    end)
    assert.has_error(function()
      ctest:new("/path/to/project")
    end, "Failed to locate CTest test directory")
  end)

  it("should throw error if ctest version is below 3.21", function()
    stub(scandir, "scan_dir", function(_, _)
      return { cwd .. "/CTestTestfiles.cmake" }
    end)
    stub(ctest, "run", function(_)
      return "3.20.0"
    end)
    assert.has_error(function()
      ctest:new("/path/to/project")
    end, "CTest version 3.21+ is required")
  end)
end)

describe("ctest:testcases", function()
  it("should parse all tests into a table", function()
    stub(ctest, "run", function(_)
      return vim.json.encode({
        ["tests"] = {
          { ["name"] = "First" },
          { ["name"] = "Second" },
        },
      })
    end)

    local actual_testcases = ctest:testcases()
    local expected_testcases = {
      ["First"] = 1,
      ["Second"] = 2,
    }

    assert.are.same(expected_testcases, actual_testcases)
  end)
end)
