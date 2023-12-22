local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier
    },
    cpp = {
      require("formatter.filetypes.cpp").clang_format
    },
  }
}

return M
