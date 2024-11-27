vim.notify = print
vim.opt.swapfile = false
vim.opt.rtp:append(".")
vim.opt.rtp:append("./deps/plenary.nvim")
vim.opt.rtp:append("./deps/nvim-nio")
vim.opt.rtp:append("./deps/neotest")
vim.opt.rtp:append("./deps/nvim-treesitter")

vim.cmd("runtime plugin/plenary.vim")
