return {
    {
        "mhartington/formatter.nvim",
        config = function()
            require("formatter").setup({
                filetype = {
                  python = {
                    -- Configure Ruff for sorting imports
                    function()
                        return {
                            exe = "ruff",  -- Make sure ruff is installed and in your PATH
                            args = {"--select", "I001", "--ignore", "F401", "--fix", "-"},
                            stdin = true
                        }
                    end,
                    -- Configure Ruff for Python formatting
                    function()
                        return {
                            exe = "ruff",  -- Make sure ruff is installed and in your PATH
                            args = {"format", "-"},  -- Ruff format command
                            stdin = true
                        }
                    end
                  },
                }
              })
        end,
    }
}