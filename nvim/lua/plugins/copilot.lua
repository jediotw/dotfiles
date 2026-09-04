return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",

    opts = {
        copilot_node_command = "/home/saurabh/.nvm/versions/node/v22.23.2/bin/node",

        suggestion = {
            enabled = true,
            auto_trigger = true,

            keymap = {
                accept = "<Tab>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },

        panel = {
            enabled = false,
        },
    },
}
