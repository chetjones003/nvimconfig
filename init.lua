local status_ok, cjvim = pcall(require, "cjvim")
if not status_ok then
  vim.notify("cjvim: " .. cjvim, vim.log.levels.ERROR)
else
  cjvim.autocommands()
  cjvim.core_config()
  cjvim.plugins()
end

require("notify").setup({
  background_colour = "#000000",
})

-- [[Set colorscheme here]]
vim.cmd("colorscheme tokyonight-moon")
