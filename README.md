# コメント

現在はWSL2(Ubuntu)とMacで共有

プラグイン一覧はPLUGINS.mdを参照

# nvim-config

Neovimの設定ファイル一式です。現在はWSL2(Ubuntu)とMacで共有しています。

## セットアップ

このリポジトリをクローンしただけでは、文字列検索（Telescope）やLSP（コード補完・定義ジャンプ）などの主要な機能が動作しません。
以下の手順に従って、必要な外部ツールをインストールしてください。

### 1. 外部依存ツールのインストール

LSPの実行や高速な検索、プラグイン管理のために、OS側に以下のツールが必要です。

- **Git**: プラグインのダウンロードに必須。
- **ripgrep (`rg`)**: 文字列検索 (`Telescope live_grep` / `Grug-far`) に必須。
- **fd (`fd`)**: 高速なファイル検索に推奨。
- **Node.js & npm**: TypeScript/JavaScript 用の LSP (`ts_ls`) や、多くの Mason ツールに必須。
- **Go (`go`)**: Go 用の LSP (`gopls`) に必須。
- **ビルドツール (`gcc`, `make` など)**: `treesitter` のパーサーコンパイルに使用。
- **Unzip / Curl / Tar**: `Mason` による外部ツールの自動ダウンロードに必須。
- **Python3 & venv**: 一部の LSP やツールを Mason でインストールする際に必要になる場合があります。

#### インストールコマンド例

**Ubuntu / WSL2 (Ubuntu):**
```bash
sudo apt update
sudo apt install -y git curl unzip tar ripgrep fd-find nodejs npm golang build-essential python3-pip python3-venv
```
> [!NOTE]
> Ubuntuの `fd-find` はコマンド名が `fdfind` となります。プラグイン側で自動判別されない場合は、エイリアス設定（`alias fd='fdfind'`）を検討してください。

**macOS (Homebrew):**
```bash
brew install git curl ripgrep fd node go
```

### 2. Nerd Font のインストール (推奨)

`neo-tree` や `lualine` でアイコンを正しく表示するために、**Nerd Font** のインストールを強く推奨します。

- [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip) などがお勧めです。
- インストール後、ターミナルのフォント設定でインストールした Nerd Font を選択してください。

### 3. クローンと初回起動

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

このリポジトリでは、プラグインを最新かつ安全な状態に保つために **GitHub Actions による自動メンテナンス** を導入しています。

### 1. 自動メンテナンス (推奨)
毎週日曜日の深夜（日本時間 月曜午前）に、GitHub Actions が全プラグインの更新をチェックします。更新がある場合、自動的に **`🚀 Plugin Updates`** という Pull Request (PR) が作成されます。

**適用手順:**
1.  GitHub 上で作成された PR の内容を確認し、マージ（Merge）します。
2.  ローカル環境で最新の状態を取得します：
    ```bash
    git pull origin main
    ```
3.  Neovim を起動し、プラグインをロックファイルの状態に同期します：
    ```vim
    :Lazy sync
    ```
    ※ `sync` を実行することで、GitHub Actions が検証済みの最新バージョンがローカルに適用されます。

### 2. 手動での即時更新
新しい機能をすぐに試したい場合などは、手動で一括更新も可能です。
```vim
:Lazy update
```
更新後は `lazy-lock.json` をコミットしてプッシュしてください。

### 3. LSP/外部ツールの更新 (Mason)
LSP サーバーやフォーマッタなどの外部バイナリを更新するには、以下のメニューを開きます。
```vim
:Mason
```
メニュー内で `u` を押すとインストール済みのツールをすべて更新できます。

### 4. セキュリティについて
定期的に自動・手動の更新を行うことで、既知の脆弱性やバグの修正を確実に取り込むことができます。
