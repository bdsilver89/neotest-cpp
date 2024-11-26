
MINIMAL_INIT = tests/unit/minimal_init.lua
PLENARY_OPTS = {minimal_init='${MINIMAL_INIT}', sequential=true, timeout=5000}

test: unit integration

unit: deps
	nvim --headless -u $(MINIMAL_INIT) -c "PlenaryBustedDirectory tests/unit ${PLENARY_OPTS}"

integration: integration-cmake
	nvim --headless -u $(MINIMAL_INIT) -c "PlenaryBustedDirectory tests/integration ${PLENARY_OPTS}"

integration-cmake:
	$(MAKE) -C tests/integration/cmake build

clean:
	rm -rf deps/
	$(MAKE) -C tests/integration/cmake clean

deps: deps/plenary.nvim deps/nvim-treesitter deps/neotest deps/nvim-nio

deps/plenary.nvim:
	mkdir -p deps
	git clone --depth 1 https://github.com/nvim-lua/plenary.nvim.git $@

deps/nvim-treesitter:
	mkdir -p deps
	git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter.git $@

deps/neotest:
	mkdir -p deps
	git clone --depth 1 https://github.com/nvim-neotest/neotest.git $@

deps/nvim-nio:
	mkdir -p deps
	git clone --depth 1 https://github.com/nvim-neotest/nvim-nio.git $@


.PHONY: test unit integration integration-cmake deps clean
