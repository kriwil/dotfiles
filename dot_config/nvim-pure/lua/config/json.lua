local M = {}

local root_markers = {
  ".git",
  "package.json",
}

local format_group = vim.api.nvim_create_augroup("nvim-pure-json-format", { clear = true })

local function setup_lsp()
  vim.lsp.config("jsonls", {
    root_markers = root_markers,
    on_attach = function(client, bufnr)
      vim.api.nvim_clear_autocmds({
        group = format_group,
        buffer = bufnr,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            async = false,
            filter = function(format_client)
              return format_client.id == client.id
            end,
          })
        end,
      })
    end,
  })

  vim.lsp.enable("jsonls")
end

function M.setup()
  setup_lsp()
end

return M
