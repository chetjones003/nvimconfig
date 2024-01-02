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
    dependencies = {
      "nvim-treesitter/playground",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "csv",
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

  -- [[Themes]]
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function ()
      return require("rose-pine").setup({
        --- @usage "auto"|"main"|"moon"|"dawn"
        variant = "moon",
        bold_vert_split = true,
        dim_nc_background = false,
        disable_background = true,
        disable_float_background = false,
        disable_italics = true,

        highlight_groups = {
          ColorColumn = { bg = "surface" },
          StatusLine = { fg = "love", bg = "love", blend = 10 },
          StatusLineNC = { fg = "subtle", bg = "surface" },
          IncSearch = { bg = "muted", fg = "base", inherit = false },
        }
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      return require("tokyonight").setup({
        transparent = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark",   -- style for floating windows
        },
      })
    end,
  },

  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function ()
      return require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        no_italic = true, -- Force no italic
        no_bold = true, -- Force no bold
        no_underline = true, -- Force no underline
        custom_highlights = {},
      })
    end,
  },

  -- NVIM TREE
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      return require("cjvim.plugins.nvimtree")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
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

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------

  -- Collection of functions that will help you setup Neovim's LSP client, 
  -- so you can get IDE-like features with minimum effort.
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
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
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- A completion engine plugin for neovim written in Lua (:help cmp)
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'onsails/lspkind.nvim' },
      { 'windwp/nvim-autopairs' },
    },
    config = function()
      return require("cjvim.plugins.cmp")
    end
  },

  -- Configs for the Nvim LSP client (:help lsp && :help lspconfig-all).
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      return require("cjvim.plugins.lspconfig")
    end
  },

  -- This is a Vim plugin that provides Rust file detection, syntax highlighting, 
  -- formatting, Syntastic integration, and more.
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- A plugin to improve your rust experience in neovim.
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      local rt = require("rust-tools")
      return rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        }
      })
    end,
  },
})
