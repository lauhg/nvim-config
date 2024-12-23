-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.ai_cmp = false
vim.g.snacks_animate = false
vim.diagnostic.disable()
-- vim.diagnostic.config({ virtual_text = false })

-- 不显示空白等特殊字符
vim.opt.list = false
vim.opt.formatoptions = "jcqlnt"
-- 不在 status bar 显示 pressed key
vim.opt.showcmd = false

if vim.g.neovide then
  -- vim.opt.guifont = "Source Code Pro:h15"

  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
end
