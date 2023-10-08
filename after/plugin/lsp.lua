local zero_status_ok, lsp_zero = pcall(require, "lsp_zero")
if not zero_status_ok then
    return
end

local config_status_ok, lspconfig = pcall(require, "lspconfig")
if not config_status_ok then
    return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_config_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_config_status_ok then
    return
end

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig.rust_analyzer.setup({})

mason.setup({})
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

lsp_zero.setup_servers({ "lua_ls", "rust_analyzer" })
