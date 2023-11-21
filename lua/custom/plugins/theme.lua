require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = false,
  underline = false,
  bold = false,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
  strikethrough = false,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
    CmpSel = { bg = "#98971a", fg = "#3c3836" },
    LineNr = { fg = "#fabd2f" },
    LineNrAbove = { fg = "#928374" },
    LineNrBelow = { fg = "#928374" },
  },
  dim_inactive = false,
  transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")
