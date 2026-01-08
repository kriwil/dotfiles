-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

vim.cmd.filetype("plugin indent on")

local g = vim.g
g.mapleader = " "
g.maplocalleader = " "
