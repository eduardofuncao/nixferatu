require("mason").setup()

require("neoscroll").setup({ duration_multiplier = 0.3 })

require("mini.pick").setup()
require("mini.files").setup()
-- require("mini.pairs").setup()

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- require("eyeliner").setup({
--   highlight_on_key = true,
--   dim = true,
-- })

-- require("love2d").setup({
--   path_to_love_bin = "love",
--   restart_on_save = false,
--   debug_window_opts = nil,
--   setup_makeprg = true,
--   identify_love_projects = true
-- })
