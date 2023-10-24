local term_ok, nvterm = pcall(require, "nvterm")
if not term_ok then
  return
else
  nvterm.setup({
    terminals = {
      shell = "fish",
      type_opts = {
        float = {
          relative = 'editor',
          row = 0.2,
          col = 0.15,
          width = 0.7,
          height = 0.8,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = .3, },
        vertical = { location = "rightbelow", split_ratio = .5 },
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    },
  })
end
