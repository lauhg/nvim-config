-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map("i", "<c-f>", "<right>", { desc = "Right" })
map("i", "<c-b>", "<left>", { desc = "Left" })
map("i", "<c-a>", "<c-o>^", { desc = "Home", silent = true })
map("i", "<c-e>", "<end>", { desc = "End" })
map("i", "<c-k>", "<c-o>D", { desc = "Kill to Line End", silent = true })
map({ "n", "v" }, "<c-m>", "%", { desc = "Match" })
map("n", "<c-a>", "^", { desc = "Move to Line Beginning" })
map("n", "-", "$", { desc = "Move to Line End" })
map("n", "ge", "G", { desc = "Move to Page End" })

map("n", "<leader>r", "<cmd>split | term python3 %<cr>", { desc = "Run Python File", nowait = true })
