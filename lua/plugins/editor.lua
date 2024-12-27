return {
  { "andymass/vim-matchup" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 40,
      },
    },
  },
  {
    "lauhg/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = false,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      delay = 300,
    },
  },
  {
    "lauhg/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<esc>"] = { "hide", "fallback" },
        ["<enter>"] = { "select_and_accept", "fallback" },
        ["<C-y>"] = { "fallback" },
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
        accept = {
          auto_brackets = {
            enabled = false,
          },
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
      keys[#keys + 1] = { "<a-n>", false }
      keys[#keys + 1] = { "<a-p>", false }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = { ["--cycle"] = true },
      winopts = {
        preview = {
          layout = "vertical",
        },
      },
    },
    keys = {
      { "<c-j>", "<enter>", ft = "fzf", mode = "t", nowait = true },
      {
        "<c-y>",
        function()
          local clipboard = vim.fn.getreg("+")
          vim.fn.feedkeys(clipboard, "n")
        end,
        ft = "fzf",
        mode = "t",
        nowait = true,
      },
      -- {
      --   "<leader><space>",
      --   function()
      --     local cwd = vim.fn.expand("%:p:h")
      --     require("fzf-lua").files({ cwd = cwd })
      --   end,
      --   desc = "Find CWD Files",
      -- },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },
  -- noice 配置必须在最后，否在不生效
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            any = {
              { event = "msg_show", find = "lines" },
              { event = "msg_show", find = "line less" },
              { event = "msg_show", find = "more line" },
              { event = "msg_show", find = "changes" },
              { event = "msg_show", find = "change" },
              { event = "msg_show", find = "codeium" },
              { event = "msg_show", find = '"[^"]+" %d+L, %d+B' },
              { event = "notify", find = "Ignoring" },
              { warning = true, find = "swapfile" },
              { error = true, find = "request failed" },
            },
          },
          opts = { skip = true },
        },
      },

      -- messages = {
      -- enabled = false,
      -- view = "notify_send",
      -- enabled = true,
      -- view = "mini",
      -- },

      -- popupmenu = {
      --   enabled = false,
      -- },
      -- notify = {
      --   enabled = false,
      -- },
      -- cmdline = {
      --   enabled = false,
      -- },
      lsp = {
        progress = {
          -- 关闭 lsp 进度提示
          enabled = false,
        },
        signature = {
          auto_open = {
            enabled = false,
          },
        },
      },
    },
  },
}
