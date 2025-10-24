----------------
-- treesitter --
----------------
-- require("nvim-treesitter.install").update({ with_sync = true })()
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "python",
    "go",
    "javascript",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "nix",
    "robot",
  },
  sync_install = false,
  highlight = {
    enable = true,
    -- Disable treesitter for markdown to allow proper concealment
    disable = { "markdown" },
  },
  indent = { enable = true },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]k"] = "@block.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]K"] = "@block.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[k"] = "@block.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
        ["[K"] = "@block.outer",
      },
    },
  },
  modules = {},
  ignore_install = {},
  auto_install = false,
})
