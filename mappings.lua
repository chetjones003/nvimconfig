local M = {}
M.general = {
  n = {
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Window left" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Window up" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Window right" },
    ["<S-h>"] = { "<cmd>bprevious<cr>" },
    ["<S-l>"] = { "<cmd>bnext<cr>" },
  },
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require("crates").upgrade_all_crates()
      end,
      "Update Crates"
    }
  },
}

return M
