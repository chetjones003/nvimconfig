local lsp_zero = require('lsp-zero')
lsp_zero.extend_cmp()

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  window = {
    completion = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel,FloatBorder:CmpBorder",
      border = "rounded",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel,FloatBorder:CmpBorder",
      border = "rounded",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = lsp_zero.cmp_format(),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  })

})
