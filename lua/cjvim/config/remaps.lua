vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")


vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<S-l>", vim.cmd.bnext)
vim.keymap.set("n", "<S-h>", vim.cmd.bprevious)

vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<cr>")
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope commands theme=ivy<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files theme=ivy<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags theme=ivy<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<cr>")

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":qa!<cr>")
vim.keymap.set("n", "<leader>so", "<cmd>so<cr>")
