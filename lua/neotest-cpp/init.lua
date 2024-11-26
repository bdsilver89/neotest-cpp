local config = require("neotest-cpp.config")
local logger = require("neotest.logging")

local Adapter = { name = "neotest-cpp" }

function Adapter.setup(opts)
  config.setup(opts)
  return Adapter
end

---@param dir string
---@return string | nil
function Adapter.root(dir)
  return config.get().root(dir)
end

---@param name string
---@param rel_path string
---@param root string
---@return boolean
function Adapter.filter_dir(name, rel_path, root)
  return config.get().filter_dir(name, rel_path, root)
end

---@param file_path string
---@return boolean
function Adapter.is_test_file(file_path)
  return config.get().is_test_file(file_path)
end

---@param file_path string
---@return neotest.Tree | nil
function Adapter.discover_positions(file_path)
  local framework = require("neotest-cpp.framework").detect(path)
  if not framework then
    logger.error("Failed to detect test framework for file: " .. path)
    return
  end

  return framework.parse_positions(path)
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function Adapter.build_spec(args)
  local tree = args and arg.tree
  if not tree then
    return
  end

  local supported_types = { "test", "namespace", "file" }
  local position = tree:data()
  if not vim.tbl_containts(supported_types, position.type) then
    return
  end

  local cwd = (vim.uv or vim.loop).cwd()
  local root = Adapter.root(position.path) or cwd

  -- TODO: this is only CTest for now...
  local ctest = require("neotest-cpp.provider.ctest"):new(root)

  local testcases = ctest:testcases()
  local runnable_tests = {}
  for _, node in tree:iter() do
    if node.type == "test" then
      table.insert(runnable_tests, testcases[node.name])
    end
  end

  local filter = string.format("-I 0,0,0,%s", table.concat(runnable_tests, ","))

  local extra_args = args.extra_args or {}
  local ctest_args = { filter, table.concat(extra_args, " ") }

  local command = ctest:command(ctest_args)
  local framework = require("neotest-cpp.framework").detect(position.path)

  return {
    command = command,
    context = {
      ctest = ctest,
      framework = framework,
    },
  }
end

local function prepare_results(tree, testsuite, framework)
  local node = tree:data()
  local results = {}

  if node.type == "file" or node.type == "namespace" then
    local passed = 0
    local failed = 0
    for _, child in pairs(tree:children()) do
      local r = prepare_results(child, testsuite, framework)
      for n, v in pairs(r) do
        results[n] = v
        if v.status == "passed" then
          passed = passed + 1
        elseif v.status == "failed" then
          failed = failed + 1
        end
      end
    end

    local status = failed > 0 and "failed" or passed > 0 and "passed" or "skipped"
    results[node.id] = { status = status, output = testsuite.summary.output }
  elseif node.type == "test" then
    local testcase = testsuite[node.name]

    if not testcase then
      logger.warn(string.format("Unknown C++ testcase '%s' (marked as skipped)"), node.name)
      results[node.id] = { status = "skipped" }
    else
      if testcase.status == "run" then
        results[node.id] = {
          status = "passed",
          short = ("Passed in %.6f seconds"):format(testcase.time),
          output = testsuite.summary.output,
        }
      elseif testsuite.status == "fail" then
        local errors = framework.parse_errors(testcase.output)

        for _, err in pairs(errors) do
          err.line = err.line - 1
        end

        results[node.id] = {
          status = "failed",
          short = testcase.output,
          output = testcase.summary.output,
          errors = errors,
        }
      else
        results[node.id] = { status = "skipped" }
      end
    end
  end

  return results
end

---@param spec neotest.RunSpec
---@param _ neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function Adapter.results(spec, _, tree)
  local context = spec.context
  local testsuite = context.ctest:parse_test_results()
  return prepare_results(tree, testsuite, context.framework)
end

return Adapter
