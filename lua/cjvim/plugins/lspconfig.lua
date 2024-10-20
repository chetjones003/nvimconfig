local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
    }
})
lsp_zero.setup_servers({ "gopls" })

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr }
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end,
        { desc = "Workspace Symbol", buffer = bufnr })
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { desc = "Open Float", buffer = bufnr })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code Action", buffer = bufnr })
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, { desc = "References", buffer = bufnr })
    vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, { desc = "Rename", buffer = bufnr })
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})
