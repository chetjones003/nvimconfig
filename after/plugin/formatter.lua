local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
    return
else
    formatter.setup({
        filetype = {
            javascript = {
                require("formatter.filetypes.javascript").prettier
            },
            typescript = {
                require("formatter.filetypes.typescript").prettier
            },
            ["*"] = {
                require("formatter.filetypes.any").remove_trailing_whitespace
            },
        }
    })
end

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    command = "FormatWriteLock"
})
