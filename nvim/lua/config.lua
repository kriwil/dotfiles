-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- cmd
vim.cmd.colorscheme("off")
vim.cmd.syntax("on")

-- lint on save
vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {
        pattern = {"*.py"},
        callback = function()
            require("lint").try_lint()
        end,
    }
)

-- autoformat on save
vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = {"*.py"},
        callback = function() 
            vim.cmd("FormatWrite")
        end,
    }
)

-- opt
vim.opt.background = "light"
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.hidden = true -- allow switching buffers without saving
vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.incsearch = true -- show search matches as you type
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true -- show the cursor position all the time
vim.opt.scrolloff = 3 -- keep 3 lines above/below cursor
vim.opt.shiftwidth = 4 -- number of spaces to use for autoindent
vim.opt.smartcase = true -- ignore case unless there is a capital letter
vim.opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for

-- keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true }) -- keep selection when indenting
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true }) -- keep selection when indenting
vim.api.nvim_set_keymap("n", "<C-l>", ":bnext<CR>", { noremap = true }) -- next buffer
vim.api.nvim_set_keymap("n", "<C-h>", ":bprev<CR>", { noremap = true }) -- previous buffer