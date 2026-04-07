local M = {}

function M.setup()
  require("mini.git").setup()

  require("mini.diff").setup({
    view = {
      style = "sign",
    },
  })
end

return M
