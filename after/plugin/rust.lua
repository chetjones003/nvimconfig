local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local rust_tools = require('rust-tools')

rust_tools.setup({
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>ra', rust_tools.code_action_group.code_action_group, {buffer = bufnr})
      vim.keymap.set('n', '<leader>rr', rust_tools.runnables.runnables, {buffer = bufnr})
    end
  },
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
})

require("crates").setup({
    src = {
        cmp = {
            enabled = true,
        },
    },
})

require('cmp').setup {
    sources = {
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "crates" },
    },
}
