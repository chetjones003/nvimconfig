---@type ChadrcConfig 
local M = {}
M.ui = {
  theme = 'catppuccin',
  hl_override = {
    Comment = { fg = "#777777" },
    Visual = { bg = "#1c1c1c" },
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    ColorColumn = { bg = "#1c1c1c" },
  }
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
