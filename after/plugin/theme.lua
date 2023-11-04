require("tokyonight").setup({
  style = "storm",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = { "qf", "help" },

  on_highlights = function(highlights, colors)
    highlights.CmpSel = { bg = colors.orange, fg = "#111111" }
    highlights.LineNr = { fg = colors.orange }
    highlights.LineNrAbove = {  fg = "#aaaaaa" }
    highlights.LineNrBelow = {  fg = "#aaaaaa" }
    highlights.BufferCurrent = {  bg = colors.bg_statusline }
    highlights.BufferInactive = {  bg = colors.bg }
    highlights.BufferTabpageFill = {  bg = colors.none }
    highlights.Visual = {  bg = "#555555" }
  end,
})

vim.cmd[[colorscheme tokyonight]]
