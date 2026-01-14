return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- luaファイルを開いた時だけ読み込む
    opts = {
      library = {
        -- NeovimのAPI（vim.xxx）やプラグインの型定義を読み込む
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
