-- [[Bootstrap Lazy]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    -- [[Treesitter]]
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require('nvim-treesitter.configs')
            configs.setup({
                ensure_installed = {
                    'lua',
                    'html',
                    'templ',
                    'go',
                    'rust',
                    'toml',
                    'vim',
                    'vimdoc',
                    'regex',
                    'bash',
                    'markdown',
                    'markdown_inline',
                    'javascript',
                    'typescript',
                    'svelte',
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- [[Telescope]]
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            defaults = {
                file_ignore_patterns = {
                    'git', 'build', 'dist', 'yarn.lock', 'node_modules'
                },
                ripgrep_arguments = {
                    'rg',
                    '--hidden',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case'
                },
            },
        },
    },

    -----------------------------------------------------------------------------
    -- UI
    -----------------------------------------------------------------------------

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        opts = {
            style = 'warmer',
            transparent = false,
            code_style = {
                comments = 'none',
            },
            highlights = {},
            diagnostics = {
                darker = true,
                undercurl = true,
                background = true,
            },
        },
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
                sidbars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            styles = {
                bold = false,
                italic = false,
                transparency = true,
            },
        },
        init = function()
            vim.cmd("colorscheme rose-pine")
        end
    },

    -- [[The best Git plugin]]
    {
        'tpope/vim-fugitive',
        lazy = false,
    },

    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'buffers' },
                lualine_x = { 'filetype', 'tabs' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        },
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            spec = {
                { '<leader>c', group = '[C]ode',    mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>f', group = '[F]ile' },
            },
        },
    },
    -----------------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------------
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            return require('cjvim.plugins.lspconfig')
        end,
    },

    -- A completion engine plugin for neovim written in Lua (:help cmp)
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        lazy = false,
        priority = 100,
        dependencies = {
            { 'onsails/lspkind.nvim' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'windwp/nvim-autopairs' },
        },
        config = function()
            return require('cjvim.plugins.cmp')
        end
    },
})
