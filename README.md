# コメント

現在はWSL2(Ubuntu)とMacで共有

プラグイン一覧はPLUGINS.mdを参照

# nvim-config

Neovimの設定ファイル一式です。現在はWSL2(Ubuntu)とMacで共有しています。

## セットアップ

このリポジトリをクローンしただけでは、文字列検索（Telescope）やLSP（コード補完・定義ジャンプ）などの主要な機能が動作しません。
以下の手順に従って、必要な外部ツールをインストールしてください。

### 1. 外部依存ツールのインストール

LSPの実行や高速な検索のために、OS側に以下のツールが必要です。

- **ripgrep (`rg`)**: 文字列検索 (`Telescope live_grep` / `Grug-far`) に必須。
- **fd (`fd`)**: 高速なファイル検索に推奨。
- **Node.js & npm**: TypeScript/JavaScript 用の LSP (`ts_ls`) に必須。
- **Go (`go`)**: Go 用の LSP (`gopls`) に必須。
- **ビルドツール (`gcc`, `make` など)**: `treesitter` のパーサーコンパイルに使用。

#### インストールコマンド例

**Ubuntu / WSL2 (Ubuntu):**
```bash
sudo apt update
sudo apt install ripgrep fd-find nodejs npm golang build-essential
```

**macOS (Homebrew):**
```bash
brew install ripgrep fd node go
```

### 2. クローンと初回起動

設定ファイルを配置した後、Neovimを起動するとプラグインの自動インストールが始まります。

```bash
# 設定ディレクトリへクローン (既存の設定がある場合はバックアップしてください)
# git clone <this-repo-url> ~/.config/nvim

# Neovimを起動
nvim
```

起動後、画面下部などでプラグインのインストールが進むので、完了するまで待機してください。
また、LSPなどの管理ツール（Mason）を確認するには、Neovim内で `:Mason` を実行してください。

## プラグインのアップデートとメンテナンス

プラグインや外部ツールを最新の状態に保つため、定期的な（例：週に一度程度）アップデートを推奨します。

### 1. プラグインの更新
Neovim 内で以下のコマンドを実行し、プラグイン本体を最新バージョンに更新します。
```vim
:Lazy update
```
更新が完了したら、Neovim を再起動して変更を適用してください。

### 2. LSP/外部ツールの更新
LSP サーバーやフォーマッタなどの外部バイナリを更新するには、以下のメニューを開きます。
```vim
:Mason
```
メニュー内で `u` を押すとインストール済みのツールをすべて更新できます。

### 3. セキュリティについて
このリポジトリでは `lazy.nvim` を使用しており、各プラグインのバージョン（コミットハッシュ）は `lazy-lock.json` に記録されています。
定期的に更新を行うことで、既知の脆弱性やバグの修正を取り込むことができます。
