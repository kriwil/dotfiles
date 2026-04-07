local M = {}

local function project_root()
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local buf = vim.api.nvim_buf_get_name(0)
  local start = buf ~= "" and vim.fs.dirname(buf) or cwd
  return vim.fs.root(start, { ".git" }) or cwd
end

local function toggle(path)
  local MiniFiles = require("mini.files")
  if not MiniFiles.close() then
    MiniFiles.open(path, false)
  end
end

local function reveal_current()
  local path = vim.api.nvim_buf_get_name(0)
  toggle(path ~= "" and path or project_root())
end

function M.setup()
  local map = vim.keymap.set

  require("mini.files").setup()

  map("n", "<leader>e", function()
    toggle(project_root())
  end, { desc = "Explorer (Root Dir)" })
  map("n", "<leader>E", function()
    toggle(vim.uv.cwd() or vim.fn.getcwd())
  end, { desc = "Explorer (cwd)" })
  map("n", "-", reveal_current, { desc = "Explorer (Reveal File)" })
end

return M
