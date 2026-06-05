local M = {}

function M.setup()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  treesitter.setup({})
  treesitter.install({
    "lua",
    "luadoc",
    "luap",
    "nix",
    "python",
    "ninja",
    "rst",
    "json",
    "jsonc",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if not lang then return end
      pcall(vim.treesitter.language.add, lang)

      -- Enable Highlighting
      if vim.treesitter.query.get(lang, "highlights") then
        vim.treesitter.start(args.buf)
      end

      -- Enable Indentation
      if vim.treesitter.query.get(lang, "indents") then
        vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
      end
    end,
  })
end

return M
