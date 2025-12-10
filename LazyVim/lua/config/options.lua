-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.background = "light"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.zenbones_lightness = "bright"

if vim.g.neovide then
  vim.o.guifont = "EnvyCodeR Nerd Font Mono:h14"
end
