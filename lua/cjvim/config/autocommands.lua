-- Helper function for creating augroups
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
