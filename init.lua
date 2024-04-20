local status_ok, cjvim = pcall(require, "cjvim")
if not status_ok then
    vim.notify("cjvim: " .. cjvim, vim.log.levels.ERROR)
else
    cjvim.autocommands()
    cjvim.core_config()
    cjvim.plugins()
end

LSP_CLIENT = function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_get_option_value("filetype", {})
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return " LSP: " .. client.name
        end
    end
    return msg
end

-- [[Set colorscheme here]]
vim.cmd("colorscheme rose-pine")
