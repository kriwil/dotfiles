vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",

  "https://github.com/mcchrish/zenbones.nvim", -- colorscheme
  "https://github.com/oskarnurm/koda.nvim", -- colorscheme
})

require("bufferline").setup()
require("todo-comments").setup()

-- require("koda").setup({ transparent = true })
vim.cmd("colorscheme zenbones")

-- bufferline
-- TODO: Add keybinds for cycling buffers
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
vim.keymap.set("n", "<C-b>", "<cmd>BufferLineCycleNext<CR>", { desc = "Cycle next buffer" })
