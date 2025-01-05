if false then
  return {}
end

return {
  "lauhg/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        filetypes = {
          asm = false,
        },
        key_bindings = {
          clear = "<c-c>",
        },
      },
    })
  end,
}
