-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("set ft=help")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = "jcqlnt2"
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "python" },
--   callback = function()
--     print("FileType python")
--     -- local python_path = require("config.util").get_python_path()
--     -- set_python_path(python_path)
--     -- vim.schedule(function()
--     --   -- local lsp = require("lspconfig")
--     --   -- lsp.pyright.setup({
--     --   --   cmd = { python_path, "-m", "pyright-langserver", "--stdio" },
--     --   -- })
--     --   -- vim.cmd(string.format("PyrightSetPythonPath %s", python_path))
--     --   set_python_path(python_path)
--     -- end)
--   end,
-- })

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local util = require("config.util")
--     util.print_table(args)
--     local bufnr = args.buf
--     local filename = vim.api.nvim_buf_get_name(bufnr)
--     local python_path = util.get_python_path(filename)
--     util.set_python_path(python_path)
--     print("set python path to " .. python_path)
--   end,
-- })

-- vim.o.updatetime = 500
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false })
--   end,
-- })

local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local function leading_spaces_count(s)
  local spaces = s:match("^%s*")
  return #spaces
end

local function most_right_word(s)
  local last_word = s:match("%S+$")
  return last_word or ""
end

local function contains(table, element)
  for _, value in ipairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function get_last_token(s)
  local special_chars = { "{", "}", "[", "]", "(", ")", ",", ".", ";", ":", '"' }

  local last_char = s:sub(-1)

  for _, char in ipairs(special_chars) do
    if last_char == char then
      return last_char
    end
  end

  local last_word = s:match("%S+$")
  return last_word or ""
end

local function get_line(lnum)
  local line_num = lnum
  if line_num > 1 then
    return vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  else
    return ""
  end
end

function _G.ocaml_indent()
  -- print("ocaml_indent")
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1]
  local col = cursor[2]
  local indent_size = vim.fn.shiftwidth()

  local indent_end_keywords = {
    "=",
    "->",
    "(",
    "[",
    "{",
  }

  local pairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
  }

  local line = vim.api.nvim_get_current_line()
  local prev_line = get_line(lnum - 1)
  local prev_line_indent = leading_spaces_count(prev_line)
  local trimmed_line = trim(prev_line)
  local last_token = get_last_token(trimmed_line)

  local old_indent = leading_spaces_count(line)
  local new_indent = old_indent

  if contains(indent_end_keywords, last_token) then
    if pairs[last_token] and trim(line):sub(-1) == pairs[last_token] then
      new_indent = prev_line_indent
    else
      new_indent = prev_line_indent + indent_size
    end
  end

  -- vim.schedule(function()
  --   -- vim.api.nvim_set_current_line(string.rep(" ", new_indent) .. trim(line))
  --   -- vim.api.nvim_win_set_cursor(0, { lnum, col + new_indent - old_indent })
  --   local new_line = string.rep(" ", new_indent) .. trim(line)
  --   vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { new_line })
  -- end)

  -- print(
  --   string.format(
  --     "lnum=(%d) col=(%d) line=(%s) prev_line_indent=(%d) indent_size=(%d) new_indent=(%d) old_indent=(%d) last word=%s",
  --     lnum,
  --     col,
  --     line,
  --     prev_line_indent,
  --     indent_size,
  --     new_indent,
  --     old_indent,
  --     last_token
  --   )
  -- )
  return new_indent
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ocaml" },
  callback = function()
    vim.bo.indentkeys = "0{,0},0),0],:,0#,!^F,!<Tab>,o,O,e"
    -- vim.bo.indentkeys = "!^F,o,O,e"
    vim.bo.indentexpr = "v:lua.ocaml_indent()"
  end,
})
