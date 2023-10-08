local status_ok, cmp_autopairs = pcall(require, "cmp_autopairs")
if not status_ok then
    return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)
