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

  vim.fn.mkdir(vim.fn.stdpath("cache"), "p")

  Snacks.setup({
    picker = { enabled = true },
    lazygit = {},
  })

  map("n", "<leader>fT", function()
    Snacks.terminal()
  end, { desc = "Terminal (cwd)" })
  map("n", "<leader>ft", function()
    Snacks.terminal(nil, { cwd = project_root() })
  end, { desc = "Terminal (Root Dir)" })
  map({ "n", "t" }, "<C-/>", function()
    Snacks.terminal.focus(nil, { cwd = project_root() })
  end, { desc = "Terminal (Root Dir)" })
  map({ "n", "t" }, "<C-_>", function()
    Snacks.terminal.focus(nil, { cwd = project_root() })
  end, { desc = "which_key_ignore" })
end

return M
