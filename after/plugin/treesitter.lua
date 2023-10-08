local treesitter_status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
    return
end

nvim_treesitter.setup {
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
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}
