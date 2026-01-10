return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- リポジトリ名を取得し、最後にスラッシュを付ける関数
      local function get_repo_name()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
        if git_root and git_root ~= "" then
          -- ディレクトリ名を取得し、最後に / を追加
          return vim.fn.fnamemodify(git_root, ":t") .. "/"
        end
        return ""
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              get_repo_name,
              color = { fg = "#ff9e64", gui = "bold" },
              padding = { left = 1, right = 0 }, -- 右側の余白を0にする
            },
            {
              "filename",
              path = 4,                          -- 4gitリポジトリからのパス
              padding = { left = 0, right = 1 }, -- 左側の余白を0にする
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
