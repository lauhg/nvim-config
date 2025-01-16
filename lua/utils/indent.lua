local function leading_spaces_count(s)
  local spaces = s:match("^%s*")
  return #spaces
end

local function get_first_token(s)
  local last_word = s:match("^%S+")
  return last_word or ""
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
  if line_num > 0 then
    return vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  else
    return ""
  end
end

local function smart_indent(indent_end_keywords, dedent_start_keywords, pairs)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lnum = cursor[1]
  local indent_size = vim.fn.shiftwidth()

  local line = vim.api.nvim_get_current_line()
  local prev_line = get_line(lnum - 1)
  local prev_line_indent = leading_spaces_count(prev_line)
  local trimmed_line = vim.trim(prev_line)
  local first_token = get_first_token(trimmed_line)
  local last_token = get_last_token(trimmed_line)

  local old_indent = leading_spaces_count(line)
  local new_indent = old_indent

  if vim.tbl_contains(indent_end_keywords, last_token) then
    if pairs[last_token] and vim.trim(line):sub(-1) == pairs[last_token] then
      new_indent = prev_line_indent
    else
      new_indent = prev_line_indent + indent_size
    end
  else
    if vim.tbl_contains(dedent_start_keywords, first_token) then
      new_indent = prev_line_indent - indent_size
    end
  end

  return new_indent
end

local function ocaml_indent()
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

  return smart_indent(indent_end_keywords, {}, pairs)
end

local function python_indent()
  local indent_end_keywords = {
    "=",
    ":",
    "(",
    "[",
    "{",
    '"""',
    "'''",
  }

  local dedent_start_keywords = {
    "return",
    "pass",
  }

  local pairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ['"""'] = '"""',
    ["'''"] = "'''",
  }
  return smart_indent(indent_end_keywords, dedent_start_keywords, pairs)
end

return {
  ocaml_indent = ocaml_indent,
  python_indent = python_indent,
}
