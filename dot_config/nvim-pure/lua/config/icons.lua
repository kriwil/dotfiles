local M = {}

function M.setup()
  local MiniIcons = require("mini.icons")

  MiniIcons.setup()

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok and type(devicons.setup) == "function" then
    devicons.setup()
  end

  MiniIcons.mock_nvim_web_devicons()
end

return M
