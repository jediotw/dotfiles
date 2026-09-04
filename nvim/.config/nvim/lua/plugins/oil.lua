return {
    {
        "stevearc/oil.nvim",

        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        cmd = "Oil",

        config = function()
            require("oil").setup({
                -- Make Oil the default directory explorer
                default_file_explorer = true,

                -- Show file icons
                columns = {
                    "icon",
                },

                -- Send deleted files to Ubuntu Trash
                delete_to_trash = true,

                -- Don't ask for confirmation on simple edits
                skip_confirm_for_simple_edits = true,

                -- Buffer options
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },

                -- Window appearance
                win_options = {
                    wrap = false,
                    signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },

                -- Show hidden files
                view_options = {
                    show_hidden = true,
                },

                -- LSP-aware file operations
                lsp_file_methods = {
                    enabled = true,
                    timeout_ms = 1000,
                    autosave_changes = false,
                },

                -- Automatically notice external filesystem changes
                watch_for_changes = true,

                -- Keep cursor constrained to filename
                constrain_cursor = "name",

                -- Keymaps
                keymaps = {
                    ["g?"] = "actions.show_help",

                    ["<CR>"] = "actions.select",

                    ["-"] = {
                        "actions.parent",
                        mode = "n",
                    },

                    ["_"] = {
                        "actions.open_cwd",
                        mode = "n",
                    },

                    ["g."] = {
                        "actions.toggle_hidden",
                        mode = "n",
                    },

                    ["g\\"] = {
                        "actions.toggle_trash",
                        mode = "n",
                    },

                    ["<C-p>"] = "actions.preview",

                    ["<C-l>"] = "actions.refresh",

                    ["<C-s>"] = {
                        "actions.select",
                        opts = {
                            vertical = true,
                        },
                    },

                    ["<C-h>"] = {
                        "actions.select",
                        opts = {
                            horizontal = true,
                        },
                    },

                    ["<C-t>"] = {
                        "actions.select",
                        opts = {
                            tab = true,
                        },
                    },

                    ["gx"] = "actions.open_external",
                },
            })
        end,
    },
}
