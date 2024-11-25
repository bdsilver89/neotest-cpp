local M = {}

local default_config = {}

local config = {}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", default_config, opts or {})
end

function M.get()
  return config
end

function M.default()
  return default_config
end

return M
