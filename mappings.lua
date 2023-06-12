local M = {}
M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <cr>",
      "Toggle BreakPoint",
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require("dap.ui.widgets");
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar",
    },
    ["<leader>dsn"] = {
      "<cmd> DapStepOver <cr>",
      "Dap Step Over",
    },
    ["<leader>dt"] = {
      "<cmd> DapTerminate <cr>",
      "Dap Terminate",
    },
    ["<leader>dd"] = {
      "<cmd> RustDebuggables <cr>",
      "Rust Debuggables",
    },
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
  }
}

return M
