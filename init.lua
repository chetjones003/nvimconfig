local status_ok, cjvim = pcall(require, "cjvim")
if not status_ok then
  vim.notify("cjvim: " .. cjvim, vim.log.levels.ERROR)
else
  cjvim.autocommands()
  cjvim.core_config()
  cjvim.plugins()
end

-- [[Set colorscheme here]]
vim.cmd("colorscheme onedark")
