local lsp_zero = require("lsp-zero")

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ["<C-y>"] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),

    -- Navigate up and down completion
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),

    -- Navigate between snippet placeholder
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  })
})

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
