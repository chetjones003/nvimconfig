require("tokyonight").setup({
  style = "storm",
  light_style = "day",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "normal",
  },
  hide_inactive_statusline = false,
  dim_inactive = true,
  lualine_bold = false,

  on_highlights = function(highlights, colors)
    highlights.CmpSel = { bg = colors.blue0 }
    highlights.LineNr = { fg = colors.green }
    highlights.LineNrAbove = { fg = colors.comment }
    highlights.LineNrBelow = { fg = colors.comment }
  end,
})

vim.cmd[[colorscheme tokyonight]]
