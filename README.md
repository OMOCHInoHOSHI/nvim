# コメント

現在はWSL2(Ubuntu)とMacで共有

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
