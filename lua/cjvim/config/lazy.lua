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
                    'vim',
                    'vimdoc',
                    'regex',
                    'bash',
                    'markdown',
                    'markdown_inline',
                    'javascript',
                    'typescript',
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

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

    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            return require('cjvim.plugins.nvim_tree')
        end,
    },

    {
        "RRethy/base16-nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd("colorscheme base16-gruvbox-dark-medium")
            vim.cmd [[
              highlight Normal guibg=NONE ctermbg=NONE
              highlight NormalNC guibg=NONE ctermbg=NONE
              highlight EndOfBuffer guibg=NONE ctermbg=NONE
              highlight LineNr guibg=NONE ctermbg=NONE
              highlight SignColumn guibg=NONE ctermbg=NONE
            ]]
        end
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
        config = function()
            return require("cjvim.plugins.which_key")
        end,
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'mason-org/mason.nvim',
                opts = {
                    ui = {
                        border = "rounded"
                    }
                }
            },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            return require('cjvim.plugins.lspconfig')
        end,
    },

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
