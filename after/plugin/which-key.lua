local wk = require("which-key")

wk.register({
    f = {
        name = "+telescope",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        f = "Find File",
        h = "Buffers",
        j = { "<cmd>Telescope commands<cr>", "Commands" },
        m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        s = "Grep Project",
        w = { "<cmd>w<cr>", "Save file" },
    },

    g = {
        name = "+git",
        s = { "<cmd>Git<cr>", "Git Status" },
    },

    l = {
        name = "+lsp",
        a = "Code Action",
        f = "Diagnostic Float",
        i = "Format",
        n = "Rename",
        r = { "<cmd>Telescope lsp_references<cr>", "References" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    },

    d = "Delete to _ register",
    e = "Toggle Lexplore",
    m = "Source Lua file",
    s = "Replace under cursor",
    u = "Undo Tree",
    x = "chmod +x",
    y = "Keep yank",
    Y = "Yank to sytem clipboard",
}, { prefix = "<leader>" })

require("which-key").setup({
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20,
        },
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
    },
})
