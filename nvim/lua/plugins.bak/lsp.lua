return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup()
            end,
        },
        {
            'williamboman/mason-lspconfig.nvim',
            config = function()
                require('mason-lspconfig').setup()
            end,
        },

    }
    -- config = function()
    --     require('lspconfig').pyright.setup{}
    -- end,
}
