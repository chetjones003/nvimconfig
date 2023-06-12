local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  dap = {
    adapter = {
      type = "executable",
      command = "/usr/lib/llvm-14/bin/lldb-vscode",
      name = "rt_lldb",
    },
  },
}

return options
