-- Some configs are taken from https://github.com/nvim-lua/kickstart.nvim

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
local g = vim.g
g.mapleader = " "
g.maplocalleader = " "

-- [[ Setting options ]]

local o = vim.o
o.number = true
o.relativenumber = true
o.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
o.showmode = false -- Don't show the mode, since it's already in the status line
o.breakindent = true -- Enable break indent
o.undofile = true -- Save undo history
o.signcolumn = "yes" -- Keep signcolumn on by default
o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- Decrease mapped sequence wait time
o.expandtab = true -- Convert tab to space
o.inccommand = "split" -- Preview substitutions live, as you type!
o.cursorline = true -- Show which line your cursor is on
o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = "unnamedplus"
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
o.confirm = true

-- [[ Basic Keymaps ]]

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymaps

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local function project_root()
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local buf = vim.api.nvim_buf_get_name(0)
  local start = buf ~= "" and vim.fs.dirname(buf) or cwd
  return vim.fs.root(start, { ".git" }) or cwd
end

vim.pack.add({
  "https://github.com/rktjmp/lush.nvim", -- zenbones requirement
  "https://github.com/mcchrish/zenbones.nvim", -- colorscheme
  "https://github.com/oskarnurm/koda.nvim", -- colorscheme
  "https://github.com/folke/snacks.nvim", -- file picker/search
  "https://github.com/nvim-tree/nvim-web-devicons", -- optional icons for picker results
})
vim.cmd("colorscheme zenbones")

local buffers = require("config.buffers")
buffers.setup()
buffers.refresh_highlights()

-- [[ Plugins stuff ]]

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

vim.cmd.filetype("plugin indent on")
