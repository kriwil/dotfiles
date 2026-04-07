local M = {}

function M.setup()
  local map = vim.keymap.set

  require("sidekick").setup({
    cli = {
      picker = "snacks",
    },
  })

  map({ "i", "n" }, "<Tab>", function()
    if require("sidekick").nes_jump_or_apply() then
      return
    end

    if vim.lsp.inline_completion.get() then
      return
    end

    return "<Tab>"
  end, { expr = true, desc = "Goto/Apply AI Suggestion" })

  map({ "n", "t", "i", "x" }, "<C-.>", function()
    require("sidekick.cli").focus()
  end, { desc = "Sidekick Focus" })

  map("n", "<leader>aa", function()
    require("sidekick.cli").toggle()
  end, { desc = "Sidekick Toggle CLI" })
  map("n", "<leader>as", function()
    require("sidekick.cli").select()
  end, { desc = "Select CLI" })
  map("n", "<leader>ad", function()
    require("sidekick.cli").close()
  end, { desc = "Detach a CLI Session" })
  map({ "n", "x" }, "<leader>at", function()
    require("sidekick.cli").send({ msg = "{this}" })
  end, { desc = "Send This" })
  map("n", "<leader>af", function()
    require("sidekick.cli").send({ msg = "{file}" })
  end, { desc = "Send File" })
  map("x", "<leader>av", function()
    require("sidekick.cli").send({ msg = "{selection}" })
  end, { desc = "Send Visual Selection" })
  map({ "n", "x" }, "<leader>ap", function()
    require("sidekick.cli").prompt()
  end, { desc = "Sidekick Select Prompt" })
end

return M
