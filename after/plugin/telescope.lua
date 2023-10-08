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
