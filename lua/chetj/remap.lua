vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<A-h>", function ()
  require("nvterm.terminal").toggle "float"
end)
vim.keymap.set("t", "<A-h>", function ()
  require("nvterm.terminal").toggle "float"
end)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<S-l>", vim.cmd.BufferNext)
vim.keymap.set("n", "<S-h>", vim.cmd.BufferPrevious)
