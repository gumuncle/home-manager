# 🏠 Home Manager Setup (macOS, Nix Flake)

このリポジトリは **macOS上でNixとHome Managerを使い、ユーザー環境を完全に宣言的に構築する**ための設定です。  
`git` などの基本ツールもNixストアから提供されるため、macOS本体に何もインストールされていなくても動作します。

---

## 📦 概要

- **対象OS:** macOS (Apple Silicon, `aarch64-darwin`)
- **構成管理:** Nix Flake + Home Manager

---

## 🧩 ディレクトリ構成

```
home-manager/
├── flake.nix              # Nix flake 定義
├── flake.lock             # 自動生成（固定依存）
├── home/
│   ├── default.nix        # Home Managerメイン設定
│   └── modules/
│       ├── shell.nix      # Zsh設定とPATH
│       ├── git.nix        # Git設定
│       └── devtools.nix   # 開発用パッケージ定義
├── scripts/
│   └── enter.sh           # nix develop を簡単に起動するスクリプト
└── README.md
```

---

## 🚀 初回セットアップ

1. **Nixをインストール**

   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. **Home Managerを適用**

   ```bash
   nix run nixpkgs#home-manager -- switch --flake .#yusuke
   ```

3. **確認**

   ```bash
   git --version
   # => git version 2.x (from /nix/store/...)
   ```

macOSにXcode Command Line Toolsがなくても `git` が動作します。

---

## ⚙️ よく使うコマンド

| 操作 | コマンド |
|------|-----------|
| 設定を反映 | `home-manager switch --flake .#yusuke` |
| 設定をテスト（dry-run） | `home-manager build --flake .#yusuke` |
| flake依存を更新 | `nix flake update` |
| Nixシェルに入る | `./scripts/enter.sh` |
| 過去設定に戻す | `home-manager rollback` |

---

## 🧠 構成のポイント

- `flake.nix`  
  → macOS (`aarch64-darwin`) 向けに Home Manager と devShell を定義  
- `home/default.nix`  
  → モジュールを読み込み、`git` を Nixストアから提供  
- `modules/git.nix`  
  → `programs.git.enable = true;` でGit設定を宣言  
- `modules/shell.nix`  
  → Zshと環境変数を宣言的に管理（`home.sessionVariables`）  
- `modules/devtools.nix`  
  → Python, Node.js, AWS CLIなど開発用ツールをNixで管理  

---

## 🧪 動作確認例

```bash
# Zsh環境でNix管理のGitが使えることを確認
echo $PATH | tr ':' '\n' | grep nix
# → ~/.nix-profile/bin が含まれていればOK

which git
# → /nix/store/xxxxxx-git-2.x/bin/git
```

---

## 🧰 開発環境の拡張例

この構成はシンプルですが、次のような拡張が可能です。

| 目的 | モジュール例 |
|------|---------------|
| VSCodeなどGUI設定も管理 | `modules/vscode.nix` |
| direnv + devShell統合 | `modules/devshell.nix` |
| macOS専用設定 | `if pkgs.stdenv.isDarwin then ...` 条件分岐 |
| CLI環境統一 | `flake.nix` の `devShells` を活用 |

---

## 🧾 参考資料

- [Home Manager – nix-community](https://github.com/nix-community/home-manager)
- [NixOS Wiki: Home Manager](https://nixos.wiki/wiki/Home_Manager)
- [Nix Flakes Guide](https://nixos.wiki/wiki/Flakes)
- [Nix on macOS](https://nixos.org/download.html#nix-install-macos)

---

## 📜 ライセンス

MIT License  
(c) 2025 Yusuke Furukawa
