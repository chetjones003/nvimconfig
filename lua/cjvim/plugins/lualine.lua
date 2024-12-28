local lualine = require('lualine')
local rosepine = require('cjvim.config.colors').RosePine
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme = {
            normal = { c = { fg = rosepine.text, bg = rosepine.surface } },
            inactive = { c = { fg = rosepine.text, bg = rosepine.base } },
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = { fg = rosepine.pine },
    padding = { left = 0, right = 1 },
}

ins_left {
    function()
        return ''
    end,
    color = function()
        local mode_color = {
            n = rosepine.rose,
            i = rosepine.foam,
            v = rosepine.iris,
            V = rosepine.iris,
            c = rosepine.love,
            no = rosepine.rose,
            s = rosepine.text,
            S = rosepine.text,
            [''] = rosepine.gold,
            ic = rosepine.text,
            R = rosepine.text,
            Rv = rosepine.text,
            cv = rosepine.text,
            ce = rosepine.rose,
            r = rosepine.text,
            rm = rosepine.text,
            ['r?'] = rosepine.text,
            ['!'] = rosepine.rose,
            t = rosepine.rose,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
}

ins_left {

    'filesize',
    cond = conditions.buffer_not_empty,
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = rosepine.gold, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = rosepine.text, gui = 'bold' } }

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        error = { fg = rosepine.rose },
        warn = { fg = rosepine.gold },
        info = { fg = rosepine.pine },
    },
}

ins_left {
    function()
        return '%='
    end,
}

ins_left {

    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = rosepine.foam, gui = 'bold' },
}

ins_right {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = rosepine.foam, gui = 'bold' },
}

ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = rosepine.foam, gui = 'bold' },
}

ins_right {
    'branch',
    icon = '',
    color = { fg = rosepine.iris, gui = 'bold' },
}

ins_right {
    'diff',
    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    diff_color = {
        added = { fg = rosepine.foam },
        modified = { fg = rosepine.love },
        removed = { fg = rosepine.rose },
    },
    cond = conditions.hide_in_width,
}

ins_right {
    function()
        return '▊'
    end,
    color = { fg = rosepine.pine },
    padding = { left = 1 },
}

lualine.setup(config)
