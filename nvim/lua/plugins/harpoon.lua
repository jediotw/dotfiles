return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- Basic Setup with auto-save enabled
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                },
            })

            -- 📌 Pin files and open menu
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
            vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Harpoon Menu" })

            -- 🔢 Direct Number Shortcuts (Muscle Memory)
            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
            vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
            vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
            vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

            -- 🔄 Next and Previous Loops (The Conveyor Belt)
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon Next File" })
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon Prev File" })
        end,
    },
}
