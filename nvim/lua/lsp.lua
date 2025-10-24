---------
-- lsp --
---------

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})

-- blink
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
  completion = {
    trigger = {
      show_on_insert_on_trigger_character = false,
      show_on_keyword = false,
      show_on_trigger_character = false,
    },
  },
})

vim.lsp.config['nil'] = {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      }
    }
  }
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = {
          love = "require",
        },
      },
      diagnostics = {
        globals = { "love", "vim" },
      },
      workspace = {
        -- Optionally add your project folder to library
        library = {
          vim.api.nvim_get_runtime_file("", true),
          "${3rd}/love2d/library",
        }
      },
      telemetry = { enable = false },
    },
  },
})


vim.lsp.config['robotcode'] = {
  cmd = { 'robotcode', 'language-server' },
  filetypes = { "robot", "resource" },
  root_dir = vim.fs.dirname(
    vim.fs.find({ 'robot.toml', 'robot.yaml', '.git' }, { upward = true })[1]
  ),
  settings = {
    robot = {
      python = {
        executable = "python"
      },
      -- Language server analysis settings
      analysis = {
        diagnostic = {
          -- Disable variable naming warnings
          variableNaming = false,
          missingDocumentation = false
        }
      },
      -- Or use more granular control
      diagnostics = {
        variableNamingConvention = "ignore",
        missingDocumentation = "ignore",
        overwrittenVariable = "hint"
      }
    }
  }
}

vim.lsp.enable({ "lua_ls", "gopls", "pyright", "nil", "robotcode" })
