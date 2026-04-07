local M = {}

function M.setup()
  vim.fn.mkdir(vim.fn.stdpath("cache"), "p")

  require("snacks").setup({
    picker = { enabled = true },
    lazygit = {},
  })
end

return M
