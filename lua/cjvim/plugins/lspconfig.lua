vim.diagnostic.config({
    virtual_text = {
        prefix = '',    -- Could be '●', '■', '▶', etc.
        spacing = 2,
        severity = nil, -- Only show diagnostics above a certain severity
        format = function(diagnostic)
            local icons = {
                [vim.diagnostic.severity.ERROR] = ' ',
                [vim.diagnostic.severity.WARN] = ' ',
                [vim.diagnostic.severity.INFO] = ' ',
                [vim.diagnostic.severity.HINT] = ' ',
            }
            local symbol = icons[diagnostic.severity] or ''
            return symbol .. diagnostic.message
        end
    },
    signs = true,             -- show signs in the gutter
    underline = true,         -- underline the offending code
    update_in_insert = false, -- do not show diagnostics while typing
    severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b0000", fg = "#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b2f00", fg = "#ffaa00" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#002d3b", fg = "#00aaff" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1c1c1c", fg = "#aaaaaa" })

local lspconfig = require("lspconfig")
local servers = {
    gopls = {},
    html = { filetypes = { 'html', 'templ' }, },
    emmet_language_server = { filetypes = { 'html', 'templ' }, },
    ts_ls = {},
    eslint = {},
    lua_ls = { settings = { Lua = { diagnostics = { globals = { 'vim', }, disable = { 'missing-fields' }, }, }, }, },
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gh', vim.diagnostic.open_float, '[O]pen Float')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<C-h>', function() vim.lsp.buf.signature_help() end, "Signature Help", { 'i', 's' })
    end,
})

-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
    local signs = { Error = '', Warn = '', Hint = '', Info = '' }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require('mason').setup()
lspconfig.gopls.setup({})
lspconfig.ts_ls.setup({
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "javascript" }
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }
require('lspconfig').clangd.setup({
    cmd = { 'clangd', '--compile-commands-dir=build' }
})

require('mason-lspconfig').setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}
