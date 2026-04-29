return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
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
  },
}
