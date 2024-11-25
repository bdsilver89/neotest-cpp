
MINIMAL_INIT = tests/unit/minimal_init.lua
PLENARY_OPTS = {minimal_init='${MINIMAL_INIT}', sequential=true, timeout=5000}

test: unit

unit: deps
	nvim --headless -u $(MINIMAL_INIT) -c "PlenaryBustedDirectory tests/unit ${PLENARY_OPTS}"

clean:
	rm -rf deps/

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


.PHONY: test unit deps clean
