local status_ok, cjvim = pcall(require, "cjvim")
if not status_ok then
  vim.notify("cjvim: " .. cjvim, vim.log.levels.ERROR)
else
  cjvim.autocommands()
  cjvim.core_config()
  cjvim.plugins()
  cjvim.theme()
end

vim.opt.rtp:append("~/my_nvim_plugins/stackmap/")
vim.opt.rtp:append("~/my_nvim_plugins/cogo_nvim/")

-- GLOBAL FUNCTIONS FOR PLUGIN DEVELOPMENT AND EASY RELOADING
P = function (v)
  print(vim.inspect(v))
  return v
end

RELOAD = function (...)
  return require("plenary.reload").reload_module(...)
end

R = function (name)
  RELOAD(name)
  return require(name)
end
