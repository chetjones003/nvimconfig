vim.g.mapleader = " "
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildmode = "longest:full,full"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

vim.opt.fillchars:append({ eob = " " })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")


vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<S-l>", vim.cmd.bnext)
vim.keymap.set("n", "<S-h>", vim.cmd.bprevious)

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-l>', '<End>')
vim.keymap.set('c', '<C-h>', '<Home>')

local term_buf = nil
local term_win = nil

function _G.toggle_term_split()
	-- If terminal window is open, close (hide) it
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
		return
	end

	-- If terminal buffer doesn't exist, create it
	if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
		-- Open a new vertical split with terminal and get its buffer
		local width = math.floor(vim.o.columns / 2)
		vim.cmd(width .. "vsplit")
		term_win = vim.api.nvim_get_current_win()
		vim.cmd("terminal fish") -- or powershell, your choice

		term_buf = vim.api.nvim_get_current_buf()
		vim.cmd("startinsert")
		return
	end

	-- Terminal buffer exists, just open a split showing it
	local width = math.floor(vim.o.columns / 2)
	vim.cmd(width .. "vsplit")
	term_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(term_win, term_buf)
	vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-t>", toggle_term_split, { noremap = true, silent = true })
vim.keymap.set("i", "<C-t>", toggle_term_split, { noremap = true, silent = true })
vim.keymap.set("t", "<C-t>", [[<C-\><C-n>:lua toggle_term_split()<CR>]], { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", [[<C-\><C-n>]], { noremap = true, silent = true })

--: catppuccin
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
})
vim.cmd.colorscheme "catppuccin"

local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Check if file needs to be reloaded when changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("format_on_save"),
	pattern = { "*.go", "*.html", "*.css", "*.toml", "*.js", "*.ts", "*.lua" },
	callback = function()
		vim.lsp.buf.format()
	end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({
			timeout = 50
		})
	end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- no line numbers terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("term-open"),
	callback = function()
		vim.cmd("set ft=ps1")
		vim.cmd("setlocal nonumber norelativenumber")
	end
})

-- Close some filetypes with q
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"ps1",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Turn on spellcheck for md and gitcommit files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Disable auto adding comment characters on newline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("cj_formatoptions"),
	pattern = "*",
	callback = function()
		vim.cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
	end
})

-- User Commands --
vim.api.nvim_create_user_command("GoRunFile", function()
	vim.cmd("split")
	vim.cmd("terminal go run main.go")
end, {})

vim.api.nvim_create_user_command("GoTestProject", function()
	vim.cmd("split")
	vim.cmd("terminal go test")
end, {})

vim.api.nvim_create_user_command("GoTestFile", function()
	vim.cmd("split")
	vim.cmd("terminal go test %")
end, {})

-- NOTE: For use with formatting templ files
local custom_format = function()
	if vim.bo.filetype == "templ" then
		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local cmd = "templ fmt " .. vim.fn.shellescape(filename)

		vim.fn.jobstart(cmd, {
			on_exit = function()
				-- Reload the buffer only if it's still the current buffer
				if vim.api.nvim_get_current_buf() == bufnr then
					vim.cmd('e!')
				end
			end,
		})
	else
		vim.lsp.buf.format()
	end
end

-- Format templ on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("format_templ_on_save"),
	pattern = { "*.templ" },
	callback = function()
		custom_format()
	end
})

--: treesitter
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require('nvim-treesitter').install({ 'lua', 'go', 'html', 'templ', 'javascript', 'typescript', 'toml', 'zig' })
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'lua', 'go', 'html', 'templ', 'javascript', 'typescript', 'toml' },
	callback = function() vim.treesitter.start() end,
})

--:

--: lsp and mason
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "emmet_ls", "eslint", "ts_ls", "tailwindcss", "templ", "gopls", "zls", "clangd" },
})

vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
require("blink.cmp").setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust" }
})

--vim.lsp.enable({ "lua_ls", "basedpyright", "rust_analyzer", "djlsp", "gdscript" })

local capabilities = require('blink.cmp').get_lsp_capabilities()

local on_attach = function()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<C-,>", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return not action.disabled
			end,
		})
	end, opts)
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "gs", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
	vim.keymap.set("n", "gh", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end

vim.lsp.config("eslint", { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config("clangd", { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config("zls", { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config("gopls", { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config("ts_ls", { on_attach = on_attach, capabilities = capabilities })
vim.lsp.config("tailwindcss", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'templ', 'html', 'css' },
})
vim.lsp.config("templ", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'templ' },
})


vim.lsp.config("emmet_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "templ", "html" },
})

vim.lsp.config("lua_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					'vim',
				},
				disable = { 'missing-fields' },
			},
		},
	},
})

vim.diagnostic.config({
	virtual_text = {
		prefix = '●', -- Could be '●', '■', '▶', etc.
		spacing = 2,
		severity = nil, -- Only show diagnostics above a certain severity
		format = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = ' ',
				[vim.diagnostic.severity.WARN] = ' ',
				[vim.diagnostic.severity.INFO] = ' ',
				[vim.diagnostic.severity.HINT] = ' ',
			}
			local symbol = icons[diagnostic.severity] or ''
			return symbol .. diagnostic.message
		end
	},
	signs = true,          -- show signs in the gutter
	underline = true,      -- underline the offending code
	update_in_insert = false, -- do not show diagnostics while typing
	severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b0000", fg = "#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b2f00", fg = "#ffaa00" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#002d3b", fg = "#00aaff" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1c1c1c", fg = "#aaaaaa" })

--:

--: nvim-tree
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
require("nvim-tree").setup({
	view = {
		adaptive_size = true,
	},
	update_focused_file = {
		enable = true,
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
})

--: blink.cmp

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.files", checkout = 'stable', }
})
require('mini.files').setup({})

local minifiles_toggle = function(...)
	if not MiniFiles.close() then MiniFiles.open(...) end
end
vim.keymap.set("n", "<C-p>", minifiles_toggle)

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pairs", checkout = 'stable', }
})
require('mini.pairs').setup({})

vim.pack.add({ { src = "https://github.com/nvim-lua/plenary.nvim" } })
vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
require('telescope').setup({})
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
