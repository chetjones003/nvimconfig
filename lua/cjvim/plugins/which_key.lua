require('which-key').setup({
    plugins = {
        marks = true,
        registers = true,
    },
    win = {
        width = {
            min = 20,
            max = 100,
        },
        col = vim.api.nvim_get_option('columns') - 40,
        title = true,
        title_pos = 'center',
        border = 'single',
    },
    layout = {
        width = { min = 20, max = 50 }
    },
    spec = {
        { '<leader>c', group = '[C]ode',    mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ile' },
    },
})
