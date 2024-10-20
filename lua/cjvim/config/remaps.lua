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

vim.keymap.set("n", "<leader>e", ":Ex<cr>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope commands<cr>", { desc = "Nvim Commands" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Files" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    { desc = "Fuzzy Buffer Search" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>q", ":qa!<cr>", { desc = "Quit" })

vim.keymap.set("n", "<leader>lt", "<cmd>Trouble diagnostics<cr>", { desc = "Trouble Diagnostics" })
