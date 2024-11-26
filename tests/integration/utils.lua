local M = {}

local state

function M.setup()
  if state then
    return state
  end

  local neotest = require("neotest")
  local client

  local opts = {
    log_levels = 0,
    adapters = {
      require("neotest-cpp").setup({}),
    },
    consumers = {
      integration_tests = function(_client)
        client = _client
      end,
    },
  }

  neotest.setup(opts)

  client:get_adapters()

  local cwd = (vim.uv or vim.loop).cwd()

  local project_root = cwd
  local cmake_root = project_root .. "/tests/integration/cmake"
  local adapter_id = "neotest-cpp:" .. project_root

  state = {
    neotest = neotest,
    client = client,
    project_root = project_root,
    cmake_root = cmake_root,
    adapter_id = adapter_id,
  }

  return state
end

function M.make_neotest_id(file_path, args)
  args = args or {}

  local lib = require("neotest.lib")
  local id = lib.files.path.real(file_path)

  local sysname = (vim.uv or vim.loop).os_uname().sysname
  if sysname ~= "Linux" and sysname ~= "Darwin" then
    if id ~= nil then
      id = string.gsub(id, "/", [[\]])
    end
  end

  if args.namespace ~= nil then
    id = table.concat({ id, args.namespace }, "::")
  end

  if args.name ~= nil then
    id = table.concat({ id, args.name }, "::")
  end

  return id
end

return M
