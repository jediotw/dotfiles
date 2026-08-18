return {
    {
        "xeluxee/competitest.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },

        config = function()
            require("competitest").setup({
                testcases_directory = "./testcases",

                runner_ui = {
                    interface = "split",
                },
            })

            -- CompetiTest shortcuts
            local ct = vim.api.nvim_create_user_command

            ct("CRP", "CompetiTest receive problem", {})
            ct("CRC", "CompetiTest receive contest", {})
            ct("CRTS", "CompetiTest receive testcases", {})

            ct("CR", "CompetiTest run", {})
            ct("CRNC", "CompetiTest run_no_compile", {})

            ct("CATC", "CompetiTest add_testcase", {})
            ct("CETC", "CompetiTest edit_testcase", {})
            ct("CDTC", "CompetiTest delete_testcase", {})

            ct("CSUI", "CompetiTest show_ui", {})
        end,
    },
}
