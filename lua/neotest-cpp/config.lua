local lib = require("neotest.lib")

local M = {}

---@class NeotestCppCTestConfig

---@class NeotestCppCatch2Config

---@class NeotestCppBuildSystemConfig
---@field ctest NeotestCppCTestConfig?

---@class NeotestCppFrameworkConfig
---@field catch2 NeotestCppCatch2Config?

---@class NeotestCppConfig
---@field root fun(path: string): string | nil
---@field is_test_file fun(file_path: string): boolean
---@field filter_dir fun(name: string, rel_path: string, root: string): boolean
---@field build_systems NeotestCppBuildSystemConfig
---@field frameworks NeotestCppFrameworkConfig

local function default_root(dir)
  return lib.files.match_root_pattern(
    "CMakePresets.json",
    "compile_commands.json",
    ".clangd",
    ".clang-format",
    ".clang-tidy",
    "build",
    "out",
    ".git"
  )(dir)
end

local function default_is_test_file(file_path)
  local elems = vim.split(file_path, lib.files.sep, { plain = true })
  local name, extension = unpack(vim.split(elems[#elems], ".", { plain = true }))
  local supported_extensions = { "cpp", "cc", "cxx" }
  return vim.tbl_contains(supported_extensions, extension) and vim.endswith(name, "_test") or false
end

local function default_filter_dir(name, rel_path, root)
  local neotest_config = require("neotest.config")
  local fn = vim.tbl_get(neotest_config, "projects", root, "discovery", "filter_dir")
  if fn ~= nil then
    return fn(name, rel_path, root)
  end

  local dir_filters = {
    ["build"] = false,
    ["cmake"] = false,
    ["doc"] = false,
    ["docs"] = false,
    ["examples"] = false,
    ["out"] = false,
    ["scripts"] = false,
    ["tools"] = false,
    ["venv"] = false,
  }
  return dir_filters[name] == nil
end

---@type NeotestCppConfig
local default_config = {
  root = default_root,
  is_test_file = default_is_test_file,
  filter_dir = default_filter_dir,
  build_systems = {
    ctest = {},
  },
  frameworks = {
    catch2 = {
      headers = {},
    },
  },
}

local config = default_config ---@type NeotestCppConfig

---@param opts table?
function M.setup(opts)
  config = vim.tbl_deep_extend("force", default_config, opts or {})
end

---@return NeotestCppConfig
function M.get()
  return config
end

---@return NeotestCppConfig
function M.default()
  return default_config
end

return M
