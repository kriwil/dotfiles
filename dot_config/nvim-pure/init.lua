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

vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim", -- lightweight git diff signs
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

local pickers = require("config.pickers")
pickers.setup()

local python = require("config.python")
python.setup()

local diagnostics = require("config.diagnostics")
diagnostics.setup()

local git = require("config.git")
git.setup()

local statusline = require("config.statusline")
statusline.setup()
statusline.refresh_highlights()

-- [[ Plugins stuff ]]

vim.cmd.filetype("plugin indent on")
