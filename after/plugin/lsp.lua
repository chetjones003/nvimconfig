local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
if not lsp_ok then
    return
else
    lsp_zero.setup_servers({
        "tsserver",
        "emmet_language_server",
        "cssls",
        "rust_analyzer",
    })
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
else
    mason.setup({
        PATH = "prepend",
    })
end

local masonconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not masonconfig_ok then
    return
else
    mason_lspconfig.setup({
        ensure_installed = {
            "rust_analyzer",
            "tsserver",
            "pyright",
            "emmet_language_server",
            "cssls",
            "eslint",
            "lua_ls"
        },
        handlers = {
            lsp_zero.default_setup,
        },
    })
end


local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
else
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })
end
