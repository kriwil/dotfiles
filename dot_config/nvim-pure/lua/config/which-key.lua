local M = {}

function M.setup()
  local wk = require("which-key")

  wk.setup()

  wk.add({
    { "<leader>a", group = "AI" },
    { "<leader>aa", desc = "Sidekick Toggle CLI", mode = "n" },
    { "<leader>ad", desc = "Detach a CLI Session", mode = "n" },
    { "<leader>af", desc = "Send File", mode = "n" },
    { "<leader>ap", desc = "Sidekick Select Prompt", mode = { "n", "x" } },
    { "<leader>as", desc = "Select CLI", mode = "n" },
    { "<leader>at", desc = "Send This", mode = { "n", "x" } },
    { "<leader>av", desc = "Send Visual Selection", mode = "x" },

    { "<leader>b", group = "Buffers" },
    { "<leader>ba", desc = "Delete All Buffers", mode = "n" },
    { "<leader>bb", desc = "Switch to Other Buffer", mode = "n" },
    { "<leader>bd", desc = "Delete Buffer", mode = "n" },
    { "<leader>bo", desc = "Delete Other Buffers", mode = "n" },

    { "<leader>c", group = "Code" },
    { "<leader>cS", desc = "LSP references/definitions/... (Trouble)", mode = "n" },
    { "<leader>cs", desc = "Symbols (Trouble)", mode = "n" },

    { "<leader>e", desc = "Explorer (Root Dir)", mode = "n" },
    { "<leader>E", desc = "Explorer (cwd)", mode = "n" },

    { "<leader>f", group = "Find" },
    { "<leader>fF", desc = "Find Files (cwd)", mode = "n" },
    { "<leader>fT", desc = "Terminal (cwd)", mode = "n" },
    { "<leader>fb", desc = "Buffers", mode = "n" },
    { "<leader>fc", desc = "Find Config File", mode = "n" },
    { "<leader>ff", desc = "Find Files (Root Dir)", mode = "n" },
    { "<leader>fg", desc = "Find Files (git-files)", mode = "n" },
    { "<leader>fr", desc = "Recent", mode = "n" },
    { "<leader>ft", desc = "Terminal (Root Dir)", mode = "n" },

    { "<leader>g", group = "Git" },
    { "<leader>gG", desc = "Lazygit (cwd)", mode = "n" },
    { "<leader>gg", desc = "Lazygit (Root Dir)", mode = "n" },

    { "<leader>q", desc = "Open diagnostic [Q]uickfix list", mode = "n" },
    { "<leader>R", desc = "Restart Neovim", mode = "n" },

    { "<leader>s", group = "Search" },
    { "<leader>sB", desc = "Grep Open Buffers", mode = "n" },
    { "<leader>sb", desc = "Buffer Lines", mode = "n" },
    { "<leader>sg", desc = "Grep (Root Dir)", mode = "n" },
    { "<leader>sG", desc = "Grep (cwd)", mode = "n" },
    { "<leader>sk", desc = "Keymaps", mode = "n" },
    { "<leader>sw", desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },

    { "<leader>x", group = "Diagnostics" },
    { "<leader>xL", desc = "Location List (Trouble)", mode = "n" },
    { "<leader>xQ", desc = "Quickfix List (Trouble)", mode = "n" },
    { "<leader>xX", desc = "Buffer Diagnostics (Trouble)", mode = "n" },
    { "<leader>xx", desc = "Diagnostics (Trouble)", mode = "n" },

    { "<leader><space>", desc = "Find Files (Root Dir)", mode = "n" },
    { "<leader>/", desc = "Grep (Root Dir)", mode = "n" },
    { "<leader>`", desc = "Switch to Other Buffer", mode = "n" },

    { "<C-.>", desc = "Sidekick Focus", mode = { "n", "t", "i", "x" } },
    { "<C-/>", desc = "Terminal (Root Dir)", mode = { "n", "t" } },
    { "<Esc>", desc = "Clear Search Highlight", mode = "n" },
    { "<M-[>", desc = "Prev Copilot Suggestion", mode = { "i", "n" } },
    { "<M-]>", desc = "Next Copilot Suggestion", mode = { "i", "n" } },
    { "<S-h>", desc = "Prev Buffer", mode = "n" },
    { "<S-l>", desc = "Next Buffer", mode = "n" },
    { "-", desc = "Explorer (Reveal File)", mode = "n" },
    { "[b", desc = "Prev Buffer", mode = "n" },
    { "]b", desc = "Next Buffer", mode = "n" },
    { "<Tab>", desc = "Goto/Apply AI Suggestion", mode = { "i", "n" } },
  })
end

return M
