local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
    return
end

treesitter.setup({
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "fish",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
    },
    text_objects = {
        select = {
            enable = true,
            lookahead = true,
        },
    },
})
