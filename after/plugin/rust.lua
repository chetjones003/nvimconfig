local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
if not lsp_ok then
    return
end

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local rust_ok, rust_tools = pcall(require, "rust-tools")
if not rust_ok then
    return
end

rust_tools.setup({
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>ra", rust_tools.code_action_group.code_action_group, {buffer = bufnr})
      vim.keymap.set("n", "<leader>rr", rust_tools.runnables.runnables, {buffer = bufnr})
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

local crates_ok, crates = pcall(require, "crates")
if not crates_ok then
    return
end
crates.setup({
    src = {
        cmp = {
            enabled = true,
        },
    },
})
