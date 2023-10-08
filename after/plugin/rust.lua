local lsp_status_ok, lsp_zero = pcall(require, "lsp_zero")
if not lsp_status_ok then
    return
end

local rust_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_status_ok then
    return
end

local crates_status_ok, crates = pcall(require, "crates")
if not crates_status_ok then
    return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

rust_tools.setup({
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>ra", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "<leader>rr", rust_tools.runnables.runnables, { buffer = bufnr })
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

crates.setup({
    src = {
        cmp = {
            enabled = true,
        },
    },
})

cmp.setup {
    sources = {
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "crates" },
    },
}
