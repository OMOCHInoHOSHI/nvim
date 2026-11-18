-- nvim-treesitter は main ブランチ（全面書き直し版）を使用（lazy-lock.json 参照）
-- main では setup() の ensure_installed / highlight / indent は無視されるため、
-- install() とハイライト・インデントの有効化を自前で行う
-- 必要なもの: tree-sitter CLI（0.26.1 以上、npm 版は不可）・C コンパイラ・tar・curl
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main は遅延読み込み非対応
    build = ":TSUpdate",
    config = function()
      local parsers = { "go", "gomod", "gosum", "typescript", "tsx", "javascript", "lua" }

      -- CLI が無い環境で毎回エラーにならないよう、ある時だけインストール（導入済みなら何もしない）
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(parsers)
      end

      -- 上の言語の filetype でハイライトとインデントを有効化
      local filetypes = {}
      for _, lang in ipairs(parsers) do
        vim.list_extend(filetypes, vim.treesitter.language.get_filetypes(lang))
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          -- パーサー未導入（インストール中など）の場合は何もしない
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
