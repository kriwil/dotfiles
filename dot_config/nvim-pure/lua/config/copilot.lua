local M = {}

local inline_group = vim.api.nvim_create_augroup("nvim-pure-copilot-inline", { clear = true })

local function setup_lsp()
  vim.lsp.config("copilot", {
    handlers = {
      didChangeStatus = function(err, res)
        if err or res.status ~= "Error" then
          return
        end

        vim.schedule(function()
          vim.notify("Copilot needs sign-in. Use :LspCopilotSignIn", vim.log.levels.WARN)
        end)
      end,
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = inline_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or client.name ~= "copilot" then
        return
      end

      local bufnr = args.buf
      if not client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
        return
      end

      vim.schedule(function()
        vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
      end)

      vim.keymap.set({ "i", "n" }, "<M-]>", function()
        vim.lsp.inline_completion.select({ count = 1 })
      end, { buffer = bufnr, desc = "Next Copilot Suggestion" })

      vim.keymap.set({ "i", "n" }, "<M-[>", function()
        vim.lsp.inline_completion.select({ count = -1 })
      end, { buffer = bufnr, desc = "Prev Copilot Suggestion" })
    end,
  })

  vim.lsp.enable("copilot")
end

function M.setup()
  setup_lsp()
end

return M
