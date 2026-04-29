local M = {}

function M.setup()
  local map = vim.keymap.set
  local obsidian = require("obsidian")

  obsidian.setup({
    legacy_commands = false, -- this will be removed in 4.0.0
    daily_notes = {
      folder = "daily-notes/",
      date_format = "YYYY/MM/YYYY-MM-DD",
    },
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian-personal",
      },
    },
  })

  map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Obsidian Today" })
  map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Obsidian New" })
  map("n", "<leader>og", "<cmd>Obsidian search<CR>", { desc = "Obsidian Search" })
  map("n", "<leader>of", "<cmd>Obsidian quick_switch<CR>", { desc = "Obsidian Quick Switch" })
end

return M
