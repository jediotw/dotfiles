return {
    {
        "kawre/leetcode.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },

        opts = {
            lang = "cpp",

            plugins = {
                non_standalone = true,
            },

            picker = {
                provider = "telescope",
            },
        },
    },
}
