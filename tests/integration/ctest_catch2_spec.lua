local assert = require("luassert")
local nio = require("nio")
local it = nio.tests.it
local before_each = nio.tests.before_each
local utils = require("tests.integration.utils")

describe("TEST_CASE", function()
  local state

  before_each(function()
    state = utils.setup()
  end)

  describe("with a passing test", function()
    it("should set status as passed", function()
      local test_file = state.cmake_root .. "/src/catch2/TEST_CASE_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE ok" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("passed", results[id].status)
    end)
  end)

  describe("with a failing test", function()
    it("should set status as 'failed'", function()
      local test_file = state.cmake_root .. "/src/catch2/TEST_CASE_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
    end)
  end)

  describe("with file containing both a passing and failing test", function()
    it("should set file status as 'failed'", function()
      local test_file = state.example_root .. "/src/catch2/TEST_CASE_test.cpp"
      local id = utils.make_neotest_id(test_file)
      local test_ok_id = utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE ok" })
      local test_fail_id =
        utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
      assert.equals("passed", results[test_ok_id].status)
      assert.equals("failed", results[test_fail_id].status)
    end)
  end)
end)

describe("TEST_CASE_METHOD", function()
  local state

  before_each(function()
    state = utils.setup()
  end)

  describe("with a passing test", function()
    it("should set status as 'passed'", function()
      local test_file = state.example_root .. "/src/catch2/TEST_CASE_METHOD_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE_METHOD ok" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("passed", results[id].status)
    end)
  end)

  describe("with a failing test", function()
    it("should set status as 'failed'", function()
      local test_file = state.example_root .. "/src/catch2/TEST_CASE_METHOD_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE_METHOD fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
    end)
  end)

  describe("with file containing both a passing and failing test", function()
    it("adapter should set file status as 'failed'", function()
      local test_file = state.example_root .. "/src/catch2/TEST_CASE_METHOD_test.cpp"
      local id = utils.make_neotest_id(test_file)
      local test_ok_id =
        utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE_METHOD ok" })
      local test_fail_id =
        utils.make_neotest_id(test_file, { name = "ctest catch2 TEST_CASE_METHOD fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
      assert.equals("passed", results[test_ok_id].status)
      assert.equals("failed", results[test_fail_id].status)
    end)
  end)
end)

describe("SCENARIO", function()
  local state

  before_each(function()
    state = utils.setup()
  end)

  describe("with a passing test", function()
    it("should set status as 'passed'", function()
      local test_file = state.example_root .. "/src/catch2/SCENARIO_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "Scenario: ctest catch2 SCENARIO ok" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("passed", results[id].status)
    end)
  end)

  describe("with a failing test", function()
    it("should set status as 'failed'", function()
      local test_file = state.example_root .. "/src/catch2/SCENARIO_test.cpp"
      local id = utils.make_neotest_id(test_file, { name = "Scenario: ctest catch2 SCENARIO fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
    end)
  end)

  describe("with file containing both a passing and failing test", function()
    it("should set file status as 'failed'", function()
      local test_file = state.example_root .. "/src/catch2/SCENARIO_test.cpp"
      local id = utils.make_neotest_id(test_file)
      local test_ok_id =
        utils.make_neotest_id(test_file, { name = "Scenario: ctest catch2 SCENARIO ok" })
      local test_fail_id =
        utils.make_neotest_id(test_file, { name = "Scenario: ctest catch2 SCENARIO fail" })

      state.neotest.run.run(id)

      local results = state.client:get_results(state.adapter_id)

      assert.equals("failed", results[id].status)
      assert.equals("passed", results[test_ok_id].status)
      assert.equals("failed", results[test_fail_id].status)
    end)
  end)
end)
