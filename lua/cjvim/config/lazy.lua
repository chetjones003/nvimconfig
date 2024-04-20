-- [[Bootstrap Lazy]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- [[Treesitter]]
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "lua",
                    "rust",
                    "go",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "regex",
                    "bash",
                    "markdown",
                    "markdown_inline",
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- [[Telescope]]
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            local telescope_config = require("telescope.config")
            local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

            table.insert(vimgrep_arguments, "--hidden")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                    pickers = {
                        find_files = {
                            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                        },
                    },
                },
            })
        end
    },

    -----------------------------------------------------------------------------
    -- UI
    -----------------------------------------------------------------------------

    -- [[Theme]]
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            return require("onedark").setup({
                style = "darker",
                transparent = true,
                code_style = {
                    comments = "none",
                },
            })
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            return require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "buffers" },
                    lualine_x = { "LSP_CLIENT()" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
            })
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    -----------------------------------------------------------------------------
    -- MISC
    -----------------------------------------------------------------------------

    -- [[Navigate nvim and tmux]]
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    -- [[Git integration for vims signcolumn]]
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function()
            return require("gitsigns").setup()
        end
    },

    -- [[The best Git plugin]]
    {
        "tpope/vim-fugitive",
        lazy = false,
    },

    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            return require("mini.files").setup()
        end
    },

    -----------------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------------

    -- Collection of functions that will help you setup Neovim"s LSP client,
    -- so you can get IDE-like features with minimum effort.
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- A completion engine plugin for neovim written in Lua (:help cmp)
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "windwp/nvim-autopairs" },
        },
        config = function()
            return require("cjvim.plugins.cmp")
        end
    },

    -- Configs for the Nvim LSP client (:help lsp && :help lspconfig-all).
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            return require("cjvim.plugins.lspconfig")
        end
    },
})
