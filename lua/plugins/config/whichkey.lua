local which_key = require("which-key")

local setup = {
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20,
        },
        presets = {
            operators = false,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        },
    },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    window = {
        border = "single",
        position = "bottom",
        margin = { 0, 0, 0, 0 },
        padding = { 1, 0, 1, 0 },
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 5,
        align = "center",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = "auto",

    triggers_blacklist = {



        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["s"] = { [[:%R$\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Under Cursor" },

    b = {
      name = "Buffers",
      d = { "<cmd>bdelete!<cr>", "Close Buffer" },
    },

    p = {
        name = "Lazy",
        r = { "<cmd>Lazy reload<cr>", "Reload" },
        u = { "<cmd>Lazy update<cr>", "Update" },
    },

    f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        b = {
            "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
            "Find Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help Tags" },
        j = { "<cmd>Telescope command_history<cr>", "Find Command History" },
        m = { "<cmd>Telescope man_pages<cr>", "Find Man Pages" },
        s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Search in Current Buffer" },
    },

    g = {
        name = "Git",
        s = { "<cmd>Git<cr>", "Git Status" },
        p = { "<cmd>Git push<cr>", "Git Push" },
    },

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = {
            "<cmd>lua vim.diagnostic.open_float()<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Telescope diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        j = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
