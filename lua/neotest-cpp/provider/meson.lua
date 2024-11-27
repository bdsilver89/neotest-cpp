local lib = require("neotest.lib")
local nio = require("nio")

local M = {}

function M:run(args)
  local cmd = { "meson", "test", "-C", self._test_dir, unpack(args) }
  local _, result = lib.process.run(cmd, { stdout = true, stderr = true })

  return result.stdout
end

function M:new(cwd)
  local scandir = require("plenary.scandir")

  local meson_roots = scandir.scan_dir(cwd, {
    respect_gitignore = false,
    depth = 3,
    search_pattern = "meson.build",
    silent = true,
  })

  local test_dir = next(meson_roots) and meson_roots[1] or nil
  if not test_dir then
    error("Failed to locate Meson directory")
  end

  -- TODO: is a meson version check needed?

  local output_meson_log_path = test_dir .. lib.files.sep .. "meson-logs"
  local output_junit_path = output_meson_log_path .. lib.files.sep .. "testlog.junit.xml"
  local output_log_path = output_meson_log_path .. lib.files.sep .. "testlog.txt"

  local session = {
    _test_dir = test_dir,
    _output_junit_path = output_junit_path,
    _output_log_path = output_log_path,
  }
  setmetatable(session, self)
  self.__index = self

  return session
end

function M:command(args)
  args = args or {}
  local cmd = {
    "meson",
    "test",
    "-C",
    self._test_dir,
    "--print-errorlogs",
    table.concat(args, " "),
  }
  return table.concat(cmd, " ")
end

function M:testcases()
  local testcases = {}

  -- TODO: how do we query meson for tests?

  return testcases
end

function M:parse_test_results()
  local junit_data = lib.files.read(self._output_junit_path)
  local junit = lib.xml.parse(junit_data)
  local testsuite = junit.testsuite
  local testcases = tonumber(testsuite._attr.tests) < 2 and { testsuite.testcase }
    or testsuite.testcase

  local results = {}

  local total_time = 0

  for _, testcase in ipairs(testcases) do
    local name = testcase._attr.name
    local status = testcase._attr.status
    local time = tonumber(testcase._attr.time)
    total_time = total_time + time

    local output = testcase["system-out"]

    result[name] = {
      status = status,
      time = time,
      output = output,
    }
  end

  results.summary = {
    tests = tonumber(testsuite._attr.tests),
    failures = tonumber(testsuite._attr.failures),
    skipped = tonumber(testsuite._attr.skipped),
    time = total_time,
    output = self._output_log_path,
  }

  return results
end

return M
