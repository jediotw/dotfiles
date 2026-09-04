local M = {}

M.palettes = {
    morning = {
        background = "#F7F1DF",
        surface = "#EEE8D5",
        hover = "#E5DFCC",
        selection = "#D9E3E3",
        text = "#263238",
        muted = "#687A80",
        border = "#D8D1BC",
        accent = "#268BD2",

        red = "#C94B45",
        green = "#668A32",
        yellow = "#9A7800",
        blue = "#268BD2",
        purple = "#7568A8",
        cyan = "#328C8C",
    },

    day = {
        background = "#21252B",
        surface = "#282C34",
        hover = "#30343D",
        selection = "#3E4451",
        text = "#ABB2BF",
        muted = "#7F848E",
        border = "#3A3F4B",
        accent = "#61AFEF",

        red = "#E06C75",
        green = "#98C379",
        yellow = "#E5C07B",
        blue = "#61AFEF",
        purple = "#C678DD",
        cyan = "#56B6C2",
    },

    night = {
        background = "#1E1E1E",
        surface = "#252526",
        hover = "#2A2D2E",
        selection = "#264F78",
        text = "#D0D0D0",
        muted = "#858585",
        border = "#38383D",
        accent = "#569CD6",

        red = "#D96C75",
        green = "#7FA65A",
        yellow = "#C9B978",
        blue = "#569CD6",
        purple = "#B982B4",
        cyan = "#4BB3A7",
    },
}

local function set(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.apply(name)
    local p = M.palettes[name]

    if not p then
        error("iSheild: unknown palette '" .. tostring(name) .. "'")
    end

    vim.cmd("highlight clear")

    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end

    vim.g.colors_name = "isheild-" .. name

    vim.opt.termguicolors = true

    -- ============================================================
    -- Editor
    -- ============================================================

    set("Normal", {
        fg = p.text,
        bg = p.background,
    })

    set("NormalNC", {
        fg = p.text,
        bg = p.background,
    })

    set("NormalFloat", {
        fg = p.text,
        bg = p.surface,
    })

    set("FloatBorder", {
        fg = p.border,
        bg = p.surface,
    })

    set("Cursor", {
        fg = p.background,
        bg = p.accent,
    })

    set("CursorLine", {
        bg = p.hover,
    })

    set("CursorColumn", {
        bg = p.hover,
    })

    set("ColorColumn", {
        bg = p.surface,
    })

    set("LineNr", {
        fg = p.muted,
    })

    set("CursorLineNr", {
        fg = p.accent,
        bold = true,
    })

    set("SignColumn", {
        fg = p.muted,
        bg = p.background,
    })

    set("FoldColumn", {
        fg = p.muted,
        bg = p.background,
    })

    set("Folded", {
        fg = p.muted,
        bg = p.surface,
    })

    set("Visual", {
        bg = p.selection,
    })

    set("VisualNOS", {
        bg = p.selection,
    })

    set("Search", {
        fg = p.background,
        bg = p.yellow,
    })

    set("IncSearch", {
        fg = p.background,
        bg = p.accent,
        bold = true,
    })

    set("CurSearch", {
        fg = p.background,
        bg = p.accent,
        bold = true,
    })

    set("Substitute", {
        fg = p.background,
        bg = p.yellow,
    })

    -- ============================================================
    -- Windows / Borders
    -- ============================================================

    set("WinSeparator", {
        fg = p.border,
        bg = p.background,
    })

    set("VertSplit", {
        fg = p.border,
        bg = p.background,
    })

    set("EndOfBuffer", {
        fg = p.border,
    })

    set("NonText", {
        fg = p.border,
    })

    set("Whitespace", {
        fg = p.border,
    })

    -- ============================================================
    -- Statusline
    -- ============================================================

    set("StatusLine", {
        fg = p.text,
        bg = p.surface,
    })

    set("StatusLineNC", {
        fg = p.muted,
        bg = p.surface,
    })

    set("TabLine", {
        fg = p.muted,
        bg = p.surface,
    })

    set("TabLineFill", {
        fg = p.muted,
        bg = p.background,
    })

    set("TabLineSel", {
        fg = p.text,
        bg = p.hover,
        bold = true,
    })

    -- ============================================================
    -- Popup menu
    -- ============================================================

    set("Pmenu", {
        fg = p.text,
        bg = p.surface,
    })

    set("PmenuSel", {
        fg = p.text,
        bg = p.selection,
        bold = true,
    })

    set("PmenuSbar", {
        bg = p.hover,
    })

    set("PmenuThumb", {
        bg = p.muted,
    })

    -- ============================================================
    -- Messages
    -- ============================================================

    set("ErrorMsg", {
        fg = p.red,
        bold = true,
    })

    set("WarningMsg", {
        fg = p.yellow,
        bold = true,
    })

    set("ModeMsg", {
        fg = p.accent,
        bold = true,
    })

    set("MoreMsg", {
        fg = p.accent,
    })

    set("Question", {
        fg = p.accent,
    })

    set("Title", {
        fg = p.accent,
        bold = true,
    })

    -- ============================================================
    -- Syntax
    --
    -- Principle:
    -- Most code stays readable and low-intensity.
    -- Strong colors are reserved for semantic meaning.
    -- ============================================================

    set("Comment", {
        fg = p.muted,
        italic = true,
    })

    set("Constant", {
        fg = p.yellow,
    })

    set("String", {
        fg = p.green,
    })

    set("Character", {
        fg = p.green,
    })

    set("Number", {
        fg = p.yellow,
    })

    set("Boolean", {
        fg = p.yellow,
    })

    set("Float", {
        fg = p.yellow,
    })

    set("Identifier", {
        fg = p.text,
    })

    set("Function", {
        fg = p.blue,
    })

    set("Statement", {
        fg = p.purple,
    })

    set("Conditional", {
        fg = p.purple,
    })

    set("Repeat", {
        fg = p.purple,
    })

    set("Label", {
        fg = p.purple,
    })

    set("Operator", {
        fg = p.accent,
    })

    set("Keyword", {
        fg = p.purple,
    })

    set("Exception", {
        fg = p.red,
    })

    set("PreProc", {
        fg = p.purple,
    })

    set("Include", {
        fg = p.purple,
    })

    set("Define", {
        fg = p.purple,
    })

    set("Macro", {
        fg = p.purple,
    })

    set("Type", {
        fg = p.cyan,
    })

    set("StorageClass", {
        fg = p.cyan,
    })

    set("Structure", {
        fg = p.cyan,
    })

    set("Typedef", {
        fg = p.cyan,
    })

    set("Special", {
        fg = p.accent,
    })

    set("SpecialChar", {
        fg = p.accent,
    })

    set("Tag", {
        fg = p.accent,
    })

    set("Delimiter", {
        fg = p.text,
    })

    set("Underlined", {
        fg = p.accent,
        underline = true,
    })

    set("Error", {
        fg = p.red,
        bold = true,
    })

    set("Todo", {
        fg = p.background,
        bg = p.yellow,
        bold = true,
    })

    -- ============================================================
    -- Treesitter
    -- ============================================================

    set("@comment", {
        link = "Comment",
    })

    set("@string", {
        link = "String",
    })

    set("@string.escape", {
        fg = p.accent,
    })

    set("@number", {
        link = "Number",
    })

    set("@boolean", {
        link = "Boolean",
    })

    set("@constant", {
        link = "Constant",
    })

    set("@constant.builtin", {
        fg = p.yellow,
    })

    set("@variable", {
        fg = p.text,
    })

    set("@variable.builtin", {
        fg = p.accent,
    })

    set("@function", {
        link = "Function",
    })

    set("@function.call", {
        fg = p.blue,
    })

    set("@function.builtin", {
        fg = p.blue,
    })

    set("@keyword", {
        link = "Keyword",
    })

    set("@keyword.function", {
        fg = p.purple,
    })

    set("@keyword.return", {
        fg = p.purple,
    })

    set("@type", {
        link = "Type",
    })

    set("@type.builtin", {
        fg = p.cyan,
    })

    set("@operator", {
        link = "Operator",
    })

    set("@property", {
        fg = p.text,
    })

    set("@field", {
        fg = p.text,
    })

    set("@parameter", {
        fg = p.text,
    })

    set("@constructor", {
        fg = p.cyan,
    })

    set("@tag", {
        fg = p.accent,
    })

    set("@tag.attribute", {
        fg = p.cyan,
    })

    -- ============================================================
    -- Diagnostics
    -- ============================================================

    set("DiagnosticError", {
        fg = p.red,
    })

    set("DiagnosticWarn", {
        fg = p.yellow,
    })

    set("DiagnosticInfo", {
        fg = p.blue,
    })

    set("DiagnosticHint", {
        fg = p.cyan,
    })

    set("DiagnosticUnderlineError", {
        undercurl = true,
        sp = p.red,
    })

    set("DiagnosticUnderlineWarn", {
        undercurl = true,
        sp = p.yellow,
    })

    set("DiagnosticUnderlineInfo", {
        undercurl = true,
        sp = p.blue,
    })

    set("DiagnosticUnderlineHint", {
        undercurl = true,
        sp = p.cyan,
    })

    -- ============================================================
    -- Diff
    -- ============================================================

    set("DiffAdd", {
        fg = p.green,
        bg = p.surface,
    })

    set("DiffChange", {
        fg = p.yellow,
        bg = p.surface,
    })

    set("DiffDelete", {
        fg = p.red,
        bg = p.surface,
    })

    set("DiffText", {
        fg = p.accent,
        bg = p.selection,
    })
end

return M
