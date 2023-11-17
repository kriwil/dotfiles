vim.cmd.colorscheme("off")
vim.cmd.syntax("on")

vim.api.nvim_create_autocmd({"BufWritePost", "BufEnter"}, {
        pattern = {"*.py"},
        callback = function()
            require("lint").try_lint()
        end,
    }
)

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = {"*.py"},
        callback = function() 
            vim.cmd("FormatWrite")
        end,
    }
)