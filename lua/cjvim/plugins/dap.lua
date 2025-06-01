local dap = require("dap")

local codelldb = vim.fn.expand(
	'C:/Users/chetj/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe')

dap.adapters.codelldb = {
	type = "executable",
	command = codelldb,
	detached = false,
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\build' .. '\\', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	}
}

-- reuse for C and Rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
