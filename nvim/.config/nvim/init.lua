require("isheild").start()
vim.opt.autoread = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.options")
require("config.keymaps")
require("config.lazy")
