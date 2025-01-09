-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_user_command("W", function()
  if vim.bo.modified then
    vim.cmd("w")
  end
end, {})

local map = vim.keymap.set
map("i", "<m-f>", "<c-right>", { desc = "Move Word Right" })
map("i", "<m-b>", "<c-left>", { desc = "Move Word Left" })
map("i", "<c-f>", "<right>", { desc = "Right" })
map("i", "<c-b>", "<left>", { desc = "Left" })
map("i", "<c-a>", "<c-o>^", { desc = "Home", silent = true })
map("i", "<c-e>", "<end>", { desc = "End" })
map("i", "<c-d>", "<delete>", { desc = "Delete Right Char" })
map({ "n", "v" }, "<c-a-m>", "%", { desc = "Match", remap = true })
map("n", "<c-a>", "^", { desc = "Move to Line Beginning" })
map("n", "-", "$", { desc = "Move to Line End" })
map("n", "ge", "G", { desc = "Move to Page End" })
map("n", "<m-n>", "*", { desc = "Find Next" })
map("n", "<m-p>", "#", { desc = "Find Previous" })
map("v", "p", '"0p', { desc = "Paste", noremap = true })

local function run_python_file()
  local filename = vim.fn.expand("%:p")
  local python_path = require("config.util").get_python_path()
  if vim.bo.modified then
    vim.cmd(string.format("w | split | term %s %s", python_path, filename))
  else
    vim.cmd(string.format("split | term %s %s", python_path, filename))
  end
end

local function make()
  if vim.bo.modified then
    vim.cmd(string.format("w | split | term make"))
  else
    vim.cmd(string.format("split | term make"))
  end
end

map("n", "<leader>r", function()
  vim.schedule(function()
    run_python_file()
  end)
end, { desc = "Run Python File", expr = true, nowait = true })

-- `,`
map("n", ",,", function()
  vim.schedule(function()
    if vim.bo.filetype == "python" then
      run_python_file()
    else
      make()
    end
  end)
end, { desc = "Run Python File", expr = true, nowait = true })
map("n", ",f", "<leader>ff", { desc = "Find Root Files", silent = true, remap = true })
map("n", ",r", "<leader>fr", { desc = "Find Recent Files", silent = true, remap = true })
map("n", ",b", "<leader>fb", { desc = "Find Buffers", silent = true, remap = true })
map("n", ",c", "<leader>fc", { desc = "Find Config Files", silent = true, remap = true })
map("n", ",s", "<leader>sb", { desc = "Search Current Buffer", silent = true, remap = true })
map("n", ",g", "<leader>sg", { desc = "Grep Project", silent = true, remap = true })
map("n", ",h", "[m", { desc = "Goto Function Start", silent = true, remap = true })
map("n", ",l", "]M", { desc = "Goto Function End", silent = true, remap = true })
map("n", ",H", "[c", { desc = "Goto Class Start", silent = true, remap = true })
map("n", ",L", "]C", { desc = "Goto Class End", silent = true, remap = true })
map("n", "<leader>o", "<leader>ss", { desc = "Goto Symbol", silent = true, remap = true })
map("n", "<leader><space>", "<leader>fb", { desc = "Find Buffers", silent = true, remap = true })

map({ "n", "i" }, "<m-r>", function()
  vim.schedule(function()
    run_python_file()
  end)
end, { desc = "Run Python File", expr = true, nowait = true })

map("n", "<c-tab>", "<cmd>e #<cr>", { desc = "Other Buffer" })

-- delete
-- map("i", "<m-d>", "<c-o>dw", { desc = "Delete Word", silent = true })

-- comment
map("n", "<m-/>", "gcc", { desc = "Comment", remap = true })
map("v", "<m-/>", "gc", { desc = "Comment", remap = true })
map("i", "<m-/>", "<c-o>gcc", { desc = "Comment", remap = true })

-- undo
-- terminal 要用 <c-_>
-- map("n", "<c-_>", "u", { desc = "Undo" })
-- map("i", "<c-_>", "<c-o>u", { desc = "Undo" })
-- map("n", "<c-/>", "u", { desc = "Undo" })
-- map("i", "<c-/>", "<c-o>u", { desc = "Undo" })
local function undo()
  vim.schedule(function()
    vim.cmd("undo")
  end)
end
map("i", "<c-_>", undo, { desc = "Undo", expr = true, silent = true })
map("i", "<c-/>", undo, { desc = "Undo", expr = true, silent = true })

-- save
map({ "i", "n", "v" }, "<c-s>", "<esc>", { desc = "Escape", remap = true })
-- map({ "i", "n", "v" }, "<m-s>", "<cmd>w<cr><esc>", { desc = "Save", noremap = true })

map({ "i", "n", "v" }, "<m-s>", "<cmd>W<cr><esc>", { desc = "Save", noremap = true, silent = true })

-- paste
map("i", "<c-y>", "<c-r>+", { desc = "Paste" })

-- fold
map("n", "zl", "<cmd>%foldc<cr>", { desc = "fold all toplevels", silent = true })

-- buffer
map("n", "<m-w>", ":bd<cr>", { desc = "Close Buffer", silent = true })

map("n", "<tab>", ">>w", { desc = "Indent", noremap = true, silent = true })
map("v", "<tab>", ">gv", { desc = "Indent", noremap = true, silent = true })
map("n", "<s-tab>", "<<b", { desc = "Dedent", noremap = true, silent = true })
map("v", "<s-tab>", "<gv", { desc = "Dedent", noremap = true, silent = true })

local scroll_state = 0
local scroll_timer = vim.loop.new_timer()
map({ "n", "i" }, "<C-l>", function()
  vim.schedule(function()
    scroll_timer:stop()
    scroll_timer:start(0, 2000, function()
      scroll_state = 0
    end)
    if scroll_state == 0 then
      vim.cmd("normal! zz")
      scroll_state = 1
    elseif scroll_state == 1 then
      vim.cmd("normal! zt")
      scroll_state = 2
    else
      vim.cmd("normal! zb")
      scroll_state = 0
    end
  end)
end, { desc = "Scroll", expr = true, silent = true })

local function kill_to_line_end()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local line = vim.api.nvim_get_current_line()

  if col >= #line then
    return
  end

  vim.schedule(function()
    vim.api.nvim_buf_set_text(bufnr, row, col, row, #line, { "" })
  end)
end
map("i", "<c-k>", kill_to_line_end, { desc = "Kill to Line End", expr = true, silent = true })

local function kill_to_special_chars()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local line = vim.api.nvim_get_current_line()

  -- local special_chars = { "(", ")", "[", "]", "{", "}", '"', "'", "`", ";" }
  local special_chars = { ")", "]", "}", '"', "'", "`", ":" }
  -- 找到从光标位置到特殊字符的范围
  local target_pos = nil
  for _, char in ipairs(special_chars) do
    local pos = string.find(line, char, col + 1, true)
    if pos and (not target_pos or pos < target_pos) then
      target_pos = pos
    end
  end

  -- 如果找不到特殊字符，则退出
  if not target_pos then
    return
  end

  vim.schedule(function()
    vim.api.nvim_buf_set_text(bufnr, row, col, row, target_pos - 1, { "" })
  end)
end
map("i", "<c-s-k>", kill_to_special_chars, { desc = "Kill to Special Chars", expr = true, silent = true })

local function delete_word_forward()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local line = vim.api.nvim_get_current_line()

  local word_end = col + 1
  while word_end <= #line do
    local pos = string.find(line, "[^a-zA-Z0-9_]", word_end)
    if pos == nil then
      return
    end
    if pos == word_end and line:sub(pos, pos) == " " then
      word_end = word_end + 1
    else
      word_end = pos
      break
    end
  end

  vim.schedule(function()
    vim.api.nvim_buf_set_text(bufnr, row, col, row, word_end - 1, { "" })
  end)
end
map("i", "<m-d>", delete_word_forward, { desc = "Delete Word Forward", expr = true, silent = true })
