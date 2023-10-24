local dap, dapui = require("dap"), require("dapui")
dapui.setup({
    layouts = {
        {
            elements = {
                {
                    id = "watches",
                    size = 0.50,
                    expanded = true,
                },
                {

                    id = "scopes",
                    size = 0.50
                },
            },
            position = "left",
            size = 40
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
