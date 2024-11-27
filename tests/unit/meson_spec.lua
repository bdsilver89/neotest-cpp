local assert = require("luassert")
local stub = require("luassert.stub")
local meson = require("neotest-cpp.provider.meson")
local it = require("nio").tests.it

-- describe("meson:new", function()
--   local cwd = "/path/to/project"
--   local tempfile = "tempfile"
--   local scandir = require("plenary.scandir")
--   local lib = require("neotest.lib")
--   local fn = require("nio").fn
--
--   it("should return a valid object", function()
--     stub(scandir, "scan_dir", function(_, _)
--       return { cwd .. "/meson.build" }
--     end)
--
--     local meson_object = meson:new(cwd)
--     assert.equals(cwd, meson_object._test_dir)
--   end)
--
--   it("should throw error if not test directory is found", function()
--     stub(scandir, "scan_dir", function(_, _)
--       return {}
--     end)
--     assert.has_error(function()
--       meson:new("/path/to/project")
--     end, "Failed to locate Meson directory")
--   end)
-- end)

-- describe("ctest:testcases", function()
--   it("should parse all tests into a table", function()
--     stub(ctest, "run", function(_)
--       return vim.json.encode({
--         ["tests"] = {
--           { ["name"] = "First" },
--           { ["name"] = "Second" },
--         },
--       })
--     end)
--
--     local actual_testcases = ctest:testcases()
--     local expected_testcases = {
--       ["First"] = 1,
--       ["Second"] = 2,
--     }
--
--     assert.are.same(expected_testcases, actual_testcases)
--   end)
-- end)
