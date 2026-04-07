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

  Snacks.setup({
    picker = { enabled = true },
  })

  map("n", "<leader><space>", function()
    Snacks.picker.files({ cwd = project_root() })
  end, { desc = "Find Files (Root Dir)" })
  map("n", "<leader>/", function()
    Snacks.picker.grep({ cwd = project_root() })
  end, { desc = "Grep (Root Dir)" })
  map("n", "<leader>fb", function()
    Snacks.picker.buffers()
  end, { desc = "Buffers" })
  map("n", "<leader>fc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
  end, { desc = "Find Config File" })
  map("n", "<leader>ff", function()
    Snacks.picker.files({ cwd = project_root() })
  end, { desc = "Find Files (Root Dir)" })
  map("n", "<leader>fF", function()
    Snacks.picker.files()
  end, { desc = "Find Files (cwd)" })
  map("n", "<leader>fg", function()
    Snacks.picker.git_files({ cwd = project_root() })
  end, { desc = "Find Files (git-files)" })
  map("n", "<leader>fr", function()
    Snacks.picker.recent()
  end, { desc = "Recent" })
  map("n", "<leader>sb", function()
    Snacks.picker.lines()
  end, { desc = "Buffer Lines" })
  map("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
  end, { desc = "Grep Open Buffers" })
  map("n", "<leader>sg", function()
    Snacks.picker.grep({ cwd = project_root() })
  end, { desc = "Grep (Root Dir)" })
  map("n", "<leader>sG", function()
    Snacks.picker.grep()
  end, { desc = "Grep (cwd)" })
  map({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word({ cwd = project_root() })
  end, { desc = "Visual selection or word (Root Dir)" })
  map("n", "<leader>sk", function()
    Snacks.picker.keymaps()
  end, { desc = "Keymaps" })
end

return M
