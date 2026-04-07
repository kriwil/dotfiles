local M = {}

function M.setup()
  local ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  treesitter.setup({
    ensure_installed = {
      "lua",
      "luadoc",
      "luap",
      "python",
      "ninja",
      "rst",
    },
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  })
end

return M
