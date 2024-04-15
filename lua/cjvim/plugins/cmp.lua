local lsp_zero = require('lsp-zero')
lsp_zero.extend_cmp()

-- And you can configure cmp even more, if you want to.
local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
})

-- Set up Autopairs to work with cmp
require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)
