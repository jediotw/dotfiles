-- Leader key
vim.g.mapleader = " "

local keymap = vim.keymap

-- General
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Oil
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- LSP
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
