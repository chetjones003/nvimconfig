vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = '#131313' })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "NONE", bg = "NONE" })

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildmode = "longest:full,full"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

vim.opt.fillchars:append({ eob = " " })
