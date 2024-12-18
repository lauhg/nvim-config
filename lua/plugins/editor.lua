return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<esc>"] = { "hide", "fallback" },
      },
      -- sources = {
      --   default = { "lsp", "path", "buffer" },
      -- },
      --
      completion = {
        documentation = {
          auto_show = false,
        },
        trigger = {
          prefetch_on_insert = false,
          show_on_insert_on_trigger_character = false,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<c-j>", "<enter>", ft = "fzf", mode = "t", nowait = true },
    },
  },
  -- noice 配置必须在最后，否在不生效
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          auto_open = {
            enabled = false,
          },
        },
      },
    },
  },
}
