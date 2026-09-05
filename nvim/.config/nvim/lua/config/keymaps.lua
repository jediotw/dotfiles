vim.g.mapleader = " "

local keymap = vim.keymap

-- General
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Oil
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

keymap.set("n", "<leader>e", "<CMD>Oil<CR>", {
    desc = "File Explorer",
})

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- LSP
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })


-- Copy file path / selection reference and send it to the agent pane
local function copy_ref(opts)
    -- "%" = current buffer's file name
    -- ":." = make the path relative to Neovim's current working directory
    local path = vim.fn.expand("%:.")

    -- Start with just the file path.
    local ref = path

    if opts.visual then
        -- "v" = line where Visual mode started
        -- "." = current cursor line
        local start_line = vim.fn.line("v")
        local end_line = vim.fn.line(".")

        -- If selection was made from bottom → top,
        -- swap them so the range is always start:end.
        if start_line > end_line then
            start_line, end_line = end_line, start_line
        end

        -- Example:
        -- lua/config/keymaps.lua:1:23
        ref = path .. ":" .. start_line .. ":" .. end_line
    end

    -- Optional note/prompt to give context to the AI.
    local note = vim.fn.input("Prompt (optional): ")

    if note ~= "" then
        ref = ref .. " " .. note
    end

    -- Keep the reference in the system clipboard.
    vim.fn.setreg("+", ref)

    -- Make sure we are inside tmux.
    if vim.env.TMUX then
        -- Get the current tmux window.
        local window = vim.fn.system({
            "tmux",
            "display-message",
            "-p",
            "#S:#I",
        }):gsub("%s+$", "")

        -- Find the OpenCode pane in the current window.
        local panes = vim.fn.system({
            "tmux",
            "list-panes",
            "-t",
            window,
            "-F",
            "#{pane_id} #{pane_current_command}",
        })

        local opencode_pane

        for line in panes:gmatch("[^\r\n]+") do
            local pane_id, command = line:match("^(%S+)%s+(.+)$")

            if command == "opencode" then
                opencode_pane = pane_id
                break
            end
        end

        if opencode_pane then
            -- Send the reference to OpenCode.
            -- No Enter is sent, so the prompt is NOT submitted.
            vim.fn.system({
                "tmux",
                "send-keys",
                "-t",
                opencode_pane,
                "-l",
                ref,
            })

            vim.notify("Sent to OpenCode: " .. ref)
        else
            vim.notify(
                "OpenCode pane not found in current tmux window",
                vim.log.levels.WARN
            )
        end
    else
        vim.notify(
            "Not inside tmux — copied to clipboard only",
            vim.log.levels.WARN
        )
    end
end

-- Normal mode → copy current file path + send to OpenCode
keymap.set("n", "<leader>cp", function()
    copy_ref({})
end, { desc = "Copy file path to agent" })

-- Visual mode → copy file path + selected line range + send to OpenCode
keymap.set("v", "<leader>cp", function()
    copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })
