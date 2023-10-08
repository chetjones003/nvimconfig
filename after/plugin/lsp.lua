local lsp_zero = require("lsp-zero")

require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim"},
            },
        },
    },
})

require("lspconfig").rust_analyzer.setup({})

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
      "lua_ls",
      "rust_analyzer",
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

lsp_zero.setup_servers({"lua_ls", "rust_analyzer"})
