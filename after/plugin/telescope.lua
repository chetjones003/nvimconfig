local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fj", builtin.command_history, {})
vim.keymap.set("n", "<leader>fm", builtin.man_pages, {})
vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fr", builtin.registers, {})

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
            },
        },
    },
})
