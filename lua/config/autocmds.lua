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

_G.san_ocaml_indent = require("utils.indent").ocaml_indent
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ocaml" },
  callback = function()
    vim.bo.indentkeys = "0{,0},0),0],:,0#,!^F,!<Tab>,o,O,e"
    -- vim.bo.indentkeys = "!^F,o,O,e"
    vim.bo.indentexpr = "v:lua.san_ocaml_indent()"
  end,
})

_G.san_python_indent = require("utils.indent").python_indent
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.bo.indentkeys = "0{,0},0),0],:,0#,!^F,!<Tab>,o,O,e"
    -- vim.bo.indentkeys = "!^F,o,O,e"
    vim.bo.indentexpr = "v:lua.san_python_indent()"
  end,
})
