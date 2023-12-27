local M = {}

M.autocommands = function()
  local autocommands_ok, autocommands = pcall(require, "cjvim.config.autocommands")
  if not autocommands_ok then
    vim.notify("Autocomands: " .. autocommands, vim.log.levels.ERROR)
  else
    require("cjvim.config.autocommands")
  end
end

M.core_config = function()
  local options_ok, options = pcall(require, "cjvim.config.options")
  if not options_ok then
    vim.notify("Options: " .. options, vim.log.levels.ERROR)
  else
    require("cjvim.config.options")
  end

  local remaps_ok, remaps = pcall(require, "cjvim.config.remaps")
  if not remaps_ok then
    print("Remaps setup failed")
    vim.notify("Remaps: " .. remaps, vim.log.levels.ERROR)
  else
    require("cjvim.config.remaps")
  end

end

M.plugins = function()
  local lazy_ok, lazy = pcall(require, "cjvim.config.lazy")
  if not lazy_ok then
    vim.notify("Lazy: " .. lazy, vim.log.levels.ERROR)
  else
    require("cjvim.config.lazy")
  end
end

M.theme = function ()
  local theme_ok, theme = pcall(require, "cjvim.config.theme")
  if not theme_ok then
    vim.notify("Theme: " .. theme, vim.log.levels.ERROR)
  else
    require("cjvim.config.theme")
  end
end

return M
