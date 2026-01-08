return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim", lazy = false, priority = 1000 },
  },
  {
    "tinted-theming/tinted-vim",
  },
  {
    "oskarnurm/koda.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "koda",
    },
  },
}
