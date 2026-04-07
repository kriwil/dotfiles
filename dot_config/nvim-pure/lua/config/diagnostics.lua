local M = {}

function M.setup()
  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = {
      source = "if_many",
      spacing = 2,
      prefix = "●",
    },
    float = {
      border = "rounded",
      source = "if_many",
    },
  })
end

return M
