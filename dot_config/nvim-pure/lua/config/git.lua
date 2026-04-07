local M = {}

local function project_root()
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local buf = vim.api.nvim_buf_get_name(0)
  local start = buf ~= "" and vim.fs.dirname(buf) or cwd
  return vim.fs.root(start, { ".git" }) or cwd
end

function M.setup()
  local map = vim.keymap.set
  local Snacks = require("snacks")

  require("mini.git").setup()

  require("mini.diff").setup({
    view = {
      style = "sign",
    },
  })

  if vim.fn.executable("lazygit") == 1 then
    map("n", "<leader>gg", function()
      Snacks.lazygit({ cwd = project_root() })
    end, { desc = "Lazygit (Root Dir)" })
    map("n", "<leader>gG", function()
      Snacks.lazygit()
    end, { desc = "Lazygit (cwd)" })
  end
end

return M
