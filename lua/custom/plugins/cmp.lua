local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-y>'] = cmp.mapping.confirm({select = false}),

    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),

  sources = {
    { name = "nvim-lsp" },
    { name = "luasnnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },

})
