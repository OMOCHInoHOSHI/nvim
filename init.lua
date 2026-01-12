-- リーダーキー設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. lazy.nvim の自動インストール（ブートストラップ）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- これにより、新しいプラグインを追加したい時は lua/plugins/ にファイルを作るだけでよくなります
require("lazy").setup("plugins")

-- クリップボード
vim.opt.clipboard = 'unnamedplus'


-- WSL環境の場合のみカスタム設定
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = {'sh', '-c', 'iconv -t UTF-16LE | clip.exe'},
      ['*'] = {'sh', '-c', 'iconv -t UTF-16LE | clip.exe'},
    },
    paste = {
      ['+'] = {'sh', '-c', 'powershell.exe -NoProfile -c "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Clipboard -Raw" | sed "s/\\r$//"'},
      ['*'] = {'sh', '-c', 'powershell.exe -NoProfile -c "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Clipboard -Raw" | sed "s/\\r$//"'},
    },
    cache_enabled = 0,
  }
end


-- 行数表示
vim.opt.number = true

-- キー設定
vim.api.nvim_create_user_command('Q', 'q<bang>', { bang = true })

-- 診断表示のキーマップ
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
