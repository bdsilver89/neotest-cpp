local config = require("neotest-cpp.config")
local lib = require("neotest.lib")
local nio = require("nio")

local M = {}

local function has_matches(query, content, lang)
  nio.scheduler()

  local lang_tree = vim.treesitter.get_string_parser(content, lang, {
    injections = { [string.format("%s", lang)] = "" },
  })

  local root = lib.treesitter.fast_parse(lang_tree):root()
  local normalized_query = lib.treesitter.normalise_query(lang, query)

  for _, match in normalized_query:iter_matches(root, content) do
    if match then
      return true
    end
  end

  return false
end

function M.detect(file_path)
  local content = lib.files.read(file_path)

  for _, f in ipairs(config.get().frameworks) do
    local name = tostring(f)
    local query = ([[
  ;; query
  (preproc_include
  	path: (system_lib_string) @system.include
  	(#match? @system.include "^\\<%s/.*\\>$")
  ]]):format(name)

    local framework = require("neotest-cpp.framework." .. name)

    if has_matches(query, content, framework.lang) then
      return framework
    end
  end

  return nil
end

return M
