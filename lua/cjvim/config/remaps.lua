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

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "[E]xplorer" })
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope commands<cr>", { desc = "Find [C]ommands" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find [F]iles" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find [H]elp" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    { desc = "Fuzzy [S]earch" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find [B]uffers" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "[W]rite" })
vim.keymap.set("n", "<leader>q", ":qa!<cr>", { desc = "[Q]uit" })


vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local term_buf = nil
local term_win = nil

function _G.toggle_term_split()
    -- If terminal window is open, close (hide) it
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
        return
    end

    -- If terminal buffer doesn't exist, create it
    if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
        -- Open a new vertical split with terminal and get its buffer
        local width = math.floor(vim.o.columns / 2)
        vim.cmd(width .. "vsplit")
        term_win = vim.api.nvim_get_current_win()
        vim.cmd("terminal pwsh") -- or powershell, your choice

        term_buf = vim.api.nvim_get_current_buf()
        vim.cmd("startinsert")
        return
    end

    -- Terminal buffer exists, just open a split showing it
    local width = math.floor(vim.o.columns / 2)
    vim.cmd(width .. "vsplit")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)
    vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-t>", toggle_term_split, { noremap = true, silent = true })
vim.keymap.set("i", "<C-t>", toggle_term_split, { noremap = true, silent = true })
vim.keymap.set("t", "<C-t>", [[<C-\><C-n>:lua toggle_term_split()<CR>]], { noremap = true, silent = true })
