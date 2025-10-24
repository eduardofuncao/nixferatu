--===============
-- NVIM CONFIG ==
--===============

-------------
-- options --
-------------
vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.o.scrolloff = 6

vim.o.wrap = false
vim.o.breakindent = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.o.swapfile = false
-- vim.o.updatetime = 250
vim.o.undofile = true
vim.o.confirm = true

vim.g.have_nerd_font = true
vim.o.mouse = "a"

-- case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split" --substitution live preview

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.timeoutlen = 1000

-------------
-- keymaps --
-------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set({ "n", "v", "x" }, "[b", ":bp<CR>")
vim.keymap.set({ "n", "v", "x" }, "]b", ":bn<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>tn", ":tabnew<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>tc", ":tabclose<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>ab", ":e #<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>as", ":sf #<CR>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search highlights when pressing <esc>

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition)

vim.keymap.set("n", "<leader>sf", ":Pick files<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>", { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sh", ":Pick help<CR>", { desc = "Search help fils" })
vim.keymap.set("n", "<leader>sb", ":Pick buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Open filebexplorer" })

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
-- vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

-------------
-- plugins --
-------------
vim.pack.add({
  { src = "https://github.com/sainnhe/everforest" },
  { src = "https://github.com/vague-theme/vague.nvim"},
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = "https://github.com/L3MON4D3/LuaSnip" },

  -- { src = 'http://github.com/mfussenegger/nvim-dap' },
  -- { src = 'http://github.com/jbyuki/one-small-step-for-vimkind' },
  -- { src = 'http://github.com/leoluz/nvim-dap-go' },
  -- { src = 'http://github.com/miroshQa/debugmaster.nvim' },

  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.files" },
  -- { src = "https://github.com/echasnovski/mini.pairs" },

  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/HakonHarnes/img-clip.nvim" },

  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  -- { src = 'http://github.com/jinh0/eyeliner.nvim' },

  -- { src = 'http://github.com/S1M0N38/love2d.nvim' },
})

-------------------
-- plugins setup --
-------------------
require("plugins")

----------------
-- treesitter --
----------------
require("treesitter")

---------
-- lsp --
---------
require("lsp")

-----------
-- debug --
-----------
-- require("debugconfig")

------------
-- images --
------------
require("image")

-- spellcheck
vim.opt.spelllang = { "en_us", "pt_br" }

-----------------
-- colorscheme --
-----------------
vim.g.everforest_background = "soft" -- 'hard', 'medium', 'soft'
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_disable_italic_comment = 0
vim.g.everforest_transparent_background = 1

require("vague").setup({
  transparent = true,
})

vim.cmd.colorscheme("everforest")

vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#E0A4BA', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#725973', underline = true })
