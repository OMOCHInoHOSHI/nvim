-- return {
--   {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd([[colorscheme tokyonight]])
--     end,
--   },
-- }
--

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

-- return {
--   {
--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd([[colorscheme kanagawa]])
--     end,
--   },
-- }
