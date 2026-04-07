local M = {}

local root_markers = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

local format_group = vim.api.nvim_create_augroup("nvim-pure-python-format", { clear = true })

local function setup_lsp()
  vim.lsp.config("basedpyright", {
    root_markers = root_markers,
  })

  vim.lsp.config("ruff", {
    root_markers = root_markers,
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false

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

  vim.lsp.enable({
    "basedpyright",
    "ruff",
  })
end

function M.setup()
  setup_lsp()
end

return M
