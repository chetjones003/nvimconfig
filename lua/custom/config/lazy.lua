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

-- [[Lazy Plugins]]
require("lazy").setup({

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "bash",
          "fish",
          "json",
          "lua",
          "python",
          "rust",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
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
    end
  },

  -----------------------------------------------------------------------------
  -- UI
  -----------------------------------------------------------------------------

  -- [[Current Theme]]
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function ()
      return require("custom.plugins.theme")
    end,
  },

  -- [[Lualine]]
  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    opts = {
      theme = "gruvbox",
    },
  },

  -- [[Nvim Tree]]
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      return require("custom.plugins.nvimtree")
    end
  },

  -- [[Which Key]]
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 50
    end,
    config = function()
      return require("custom.plugins.whichkey")
    end
  },

  -----------------------------------------------------------------------------
  -- MISC
  -----------------------------------------------------------------------------

  -- [[Automatic Testing]]
  {
    "klen/nvim-test",
    lazy = false,
    config = function ()
      return require("nvim-test").setup()
    end
  },

  -- [[Navigate nvim and tmux]]
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -----------------------------------------------------------------------------
  -- Lsp
  -----------------------------------------------------------------------------
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      require("custom.plugins.lspconfig")
    end,
  },
  {'neovim/nvim-lspconfig'},
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.plugins.formatter"
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("custom.config.other").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require("custom.plugins.cmp")
    end,
  },

})
