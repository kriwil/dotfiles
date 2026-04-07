local M = {}

function M.setup()
  local map = vim.keymap.set
  local trouble = require("trouble")

  trouble.setup({
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  })

  map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
  map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
  map("n", "<leader>cs", "<cmd>Trouble symbols toggle<CR>", { desc = "Symbols (Trouble)" })
  map("n", "<leader>cS", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP references/definitions/... (Trouble)" })
  map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
  map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
end

return M
