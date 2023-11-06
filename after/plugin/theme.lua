require('rose-pine').setup({
	variant = 'auto',
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = true,
	disable_italics = true,

	groups = {
		background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
	},
	highlight_groups = {
		ColorColumn = { bg = 'rose' },
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },
		Search = { bg = 'gold', inherit = false },
    CmpSel = { bg = 'gold', fg = "#111111" },
    LineNr = { fg = 'gold' },
    LineNrAbove = {  fg = "#aaaaaa" },
    LineNrBelow = {  fg = "#aaaaaa" },
    BufferCurrent = {  bg = 'base' },
    BufferInactive = {  bg = 'base' },
    BufferTabpageFill = {  bg = 'none' },
    Visual = {  bg = "#555555" },
	}
})


vim.cmd('colorscheme rose-pine')
