return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim", lazy = false, priority = 1000 },
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    "tinted-theming/tinted-vim",
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "koda",
    },
  },
}
