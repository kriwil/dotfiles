local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true }) -- keep selection when indenting
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true }) -- keep selection when indenting
vim.api.nvim_set_keymap("n", "<C-l>", ":bnext<CR>", { noremap = true }) -- next buffer
vim.api.nvim_set_keymap("n", "<C-h>", ":bprev<CR>", { noremap = true }) -- previous buffer
