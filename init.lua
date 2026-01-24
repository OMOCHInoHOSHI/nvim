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
			['+'] = { 'sh', '-c', 'iconv -t UTF-16LE | clip.exe' },
			['*'] = { 'sh', '-c', 'iconv -t UTF-16LE | clip.exe' },
		},
		paste = {
			['+'] = { 'sh', '-c', 'powershell.exe -NoProfile -c "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Clipboard -Raw" | sed "s/\\r$//"' },
			['*'] = { 'sh', '-c', 'powershell.exe -NoProfile -c "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Get-Clipboard -Raw" | sed "s/\\r$//"' },
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

-- 診断メッセージをクリップボードにコピー
vim.keymap.set("n", "dc", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics > 0 then
		local messages = {}
		for _, d in ipairs(diagnostics) do
			table.insert(messages, d.message)
		end
		vim.fn.setreg("+", table.concat(messages, "\n"))
		print("診断をコピーしました")
	else
		print("この行に診断はありません")
	end
end, { desc = "Copy diagnostic to clipboard" })


-- 外部での変更を自動読み込み
vim.opt.autoread = true


-- 外部でファイルが変更されたら、Neovimに戻った時に自動で読み直す設定
vim.opt.autoread = true -- 念のためここでも有効化

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    -- コマンドライン入力中でなければチェックを実行
    if vim.fn.getcmdwintype() == "" then
      -- 1. ファイルの中身をディスクと同期
      vim.cmd("checktime")
    end
  end,
})

-- どうしてもLSPが追いつかない時用の「強制リセット」キー (Space + r)
vim.keymap.set("n", "<leader>r", ":LspRestart<CR>", { desc = "LSP Restart" })
