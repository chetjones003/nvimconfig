local null_ls = require("null-ls")
local opts = {
    sources = {
        null_ls.builtins.formatting.black,
    },
}
return opts
