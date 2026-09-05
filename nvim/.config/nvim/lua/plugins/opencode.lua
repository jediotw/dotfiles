return {
    {
        "NickvanDyke/opencode.nvim",

        dependencies = {
            {
                "folke/snacks.nvim",
                opts = {
                    input = {},
                    picker = {},
                    terminal = {},
                },
            },
        },

        config = function()
            vim.g.opencode_opts = {}

            vim.o.autoread = true

            vim.keymap.set({ "n", "x" }, "<leader>oa", function()
                require("opencode").ask("@this: ", { submit = true })
            end, {
                desc = "Ask OpenCode",
            })

            vim.keymap.set({ "n", "x" }, "<leader>ox", function()
                require("opencode").select()
            end, {
                desc = "OpenCode actions",
            })

            vim.keymap.set({ "n", "t" }, "<leader>ot", function()
                require("opencode").toggle()
            end, {
                desc = "Toggle OpenCode",
            })

            vim.keymap.set({ "n", "x" }, "<leader>os", function()
                return require("opencode").operator("@this ")
            end, {
                expr = true,
                desc = "Send selection to OpenCode",
            })
        end,
    },
}
