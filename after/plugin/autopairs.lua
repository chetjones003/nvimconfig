local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    return
else
    autopairs.setup()
end
