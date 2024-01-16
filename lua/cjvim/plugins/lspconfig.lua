-- This is where all the LSP shenanigans will live
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()
lsp_zero.setup_servers({ "rust_analyzer" })

lsp_zero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr }
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references theme=ivy<cr>", opts)
  vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics theme=ivy<cr>", opts)
end)

require('mason-lspconfig').setup({
  ensure_installed = {
    "rust_analyzer",
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      -- (Optional) Configure lua language server for neovim
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
