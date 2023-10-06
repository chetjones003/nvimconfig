vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use {"wbthomason/packer.nvim"}

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.3",
        requires = {"nvim-lua/plenary.nvim"}
    }

    -- UI
    use { "ellisonleao/gruvbox.nvim" }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {"nvim-tree/nvim-web-devicons"}
    }

    -- Git
    use {"tpope/vim-fugitive"}

    -- MISC
    use {"ggandor/leap.nvim"}
    use {"christoomey/vim-tmux-navigator"}
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    }

    -- LSP
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},

            -- LSP Support
            {"neovim/nvim-lspconfig"},
            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        }
    }
    use {"rust-lang/rust.vim"}
    use {"simrat39/rust-tools.nvim"}
    use {"saecki/crates.nvim"}
end)
