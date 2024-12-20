local function print_table(tbl)
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      print(k .. " = {")
      print_table(v)
      print("}")
    else
      print(k .. " = " .. tostring(v))
    end
  end
end

local function get_root_dir(filepath)
  local lsp = require("lspconfig")

  local filename = filepath or vim.fn.expand("%:p")
  local root_dir = lsp.util.root_pattern(
    ".git",
    ".gitignore",
    "requirements.txt",
    ".python-version",
    ".editorconfig",
    "pyproject.toml",
    "setup.py",
    "setup.cfg"
  )(filename)

  return root_dir
end

local function get_python_path(filepath)
  local root_dir = get_root_dir(filepath)
  local python_version_file = root_dir .. "/" .. ".python-version"
  if not vim.fn.filereadable(python_version_file) then
    return "python"
  end

  local txt = vim.fn.readfile(python_version_file)
  local pyenv = table.concat(txt, "")
  local python_path = "~/.pyenv/versions/" .. pyenv .. "/bin/python"
  return python_path
end

local function set_python_path(path)
  local util = require("lspconfig.util")
  local clients = util.get_lsp_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return {
  print_table = print_table,
  get_root_dir = get_root_dir,
  get_python_path = get_python_path,
  set_python_path = set_python_path,
}
