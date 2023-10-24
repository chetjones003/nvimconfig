local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
if not lsp_ok then
    return
end

lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local rust_ok, rust_tools = pcall(require, "rust-tools")
if not rust_ok then
    return
end

rust_tools.setup({
  dap = {
    adapter = {
      type = "executable",
      command = "/usr/bin/lldb-vscode-14",
      name = "rt_lldb",
    },
  },
  tools = {
    hover_actions = {
        auto_focus = true,
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
