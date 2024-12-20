-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map("i", "<c-f>", "<right>", { desc = "Right" })
map("i", "<c-b>", "<left>", { desc = "Left" })
map("i", "<c-a>", "<c-o>^", { desc = "Home", silent = true })
map("i", "<c-e>", "<end>", { desc = "End" })
map("i", "<c-d>", "<delete>", { desc = "Delete Right Char" })
map("i", "<c-k>", "<c-o>D", { desc = "Kill to Line End", silent = true })
map({ "n", "v" }, "<c-m>", "%", { desc = "Match" })
map("n", "<c-a>", "^", { desc = "Move to Line Beginning" })
map("n", "-", "$", { desc = "Move to Line End" })
map("n", "ge", "G", { desc = "Move to Page End" })

map("n", "<leader>r", function()
  local filename = vim.fn.expand("%:p")
  vim.schedule(function()
    local python_path = require("config.util").get_python_path()
    vim.cmd(string.format("w | split | term %s %s", python_path, filename))
  end)
end, { desc = "Run Python File", expr = true, nowait = true })

map({ "n", "i" }, "<m-r>", function()
  local filename = vim.fn.expand("%:p")
  vim.schedule(function()
    local python_path = require("config.util").get_python_path()
    vim.cmd(string.format("w | split | term %s %s", python_path, filename))
  end)
end, { desc = "Run Python File", expr = true, nowait = true })

map("n", "<c-tab>", "<cmd>e #<cr>", { desc = "Other Buffer" })

-- delete
map("i", "<m-d>", "<c-o>dw", { desc = "Delete Word", silent = true })

-- comment
map("n", "<m-/>", "gcc", { desc = "Comment", remap = true })
map("v", "<m-/>", "gc", { desc = "Comment", remap = true })
map("i", "<m-/>", "<c-o>gcc", { desc = "Comment", remap = true })

-- undo
-- terminal 要用 <c-_>
map("n", "<c-_>", "u", { desc = "Undo" })
map("i", "<c-_>", "<c-o>u", { desc = "Undo" })
map("n", "<c-/>", "u", { desc = "Undo" })
map("i", "<c-/>", "<c-o>u", { desc = "Undo" })

-- save
map({ "i", "n", "v" }, "<m-s>", "<cmd>w<cr><esc>", { desc = "Save" })
map({ "i", "n", "v" }, "<c-s>", "<esc>", { desc = "Escape", remap = true })

-- paste
map("i", "<c-y>", "<c-r>+", { desc = "Paste" })

-- unmap
-- vim.keymap.del({ "i", "n", "v" }, "<c-s>")
