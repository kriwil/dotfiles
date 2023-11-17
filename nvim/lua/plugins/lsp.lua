return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup{
                ensure_installed = { "ruff_lsp" }
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").pyright.setup{}
        end,
    }
}
