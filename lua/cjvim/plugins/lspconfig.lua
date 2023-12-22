local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "rust_analyzer",
    "clangd",
    "cmake",
    "pyright",
  },
})

lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-------------------------------------------------------------------------------
-- Lua Setup
-------------------------------------------------------------------------------
lspconfig.lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.uv.fs_stat(path .. '/.luarc.json') and not vim.uv.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

-------------------------------------------------------------------------------
-- Typescript Setup
-------------------------------------------------------------------------------
lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

-------------------------------------------------------------------------------
-- Rust Setup
-------------------------------------------------------------------------------
lspconfig.rust_analyzer.setup({})

-------------------------------------------------------------------------------
-- CPP Setup
-------------------------------------------------------------------------------
lspconfig.clangd.setup({})
lspconfig.cmake.setup({})

-------------------------------------------------------------------------------
-- Python Setup
-------------------------------------------------------------------------------
lspconfig.pyright.setup({})
