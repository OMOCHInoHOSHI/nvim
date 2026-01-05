return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "go", "gomod", "gosum", "typescript", "tsx", "javascript", "lua" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
