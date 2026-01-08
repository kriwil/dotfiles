vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})

require("mini.diff").setup({ view = { style = "sign" } })
require("mini.files").setup()
require("mini.pairs").setup()
-- require("mini.pick").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

-- mini.files
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })

-- mini.pick
-- vim.keymap.set("n", "<leader><leader>", "<cmd>Pick files<CR>", { desc = "Search files" })
-- vim.keymap.set("n", "<leader>sg", "<cmd>Pick grep<CR>", { desc = "Grep files" })
