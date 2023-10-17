local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use { "wbthomason/packer.nvim" }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" }
    }
    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.3",
        requires = { "nvim-lua/plenary.nvim" }
    }

    -- UI
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use {
        "nvim-tree/nvim-tree.lua",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use { "nvim-tree/nvim-web-devicons" }
    use { "folke/which-key.nvim" }
    use { "onsails/lspkind.nvim" }

    -- Git
    use { "tpope/vim-fugitive" }

    -- MISC
    use { "windwp/nvim-autopairs" }
    use { "ggandor/leap.nvim" }
    use { "christoomey/vim-tmux-navigator" }
    use { "mhartington/formatter.nvim" }

    -- LSP
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        }
    }
    use { "rust-lang/rust.vim" }
    use { "simrat39/rust-tools.nvim" }
    use { "saecki/crates.nvim" }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
