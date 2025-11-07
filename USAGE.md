# Home Manager Portable Setup

このflakeは複数のユーザー/PCで動作するように設計されています。

## 使用方法

### 方法1: デフォルト設定を使用
```bash
nix run nixpkgs#home-manager -- switch --flake .#default
```

### 方法2: 現在のユーザー名を使用
```bash
nix run nixpkgs#home-manager -- switch --flake .#$USER
```

### 方法3: 特定のユーザー名を使用
```bash
nix run nixpkgs#home-manager -- switch --flake .#your-username
```

## サポートされているユーザー

- `default` - どのPCでも動作する汎用設定
- `cw-yusuke.furukawa` - 特定ユーザー用
- `gumuncle` - 特定ユーザー用

新しいユーザーを追加する場合は、flake.nixの`homeConfigurations`セクションに追加してください。

## 開発環境

```bash
nix develop
# または
./scripts/enter.sh
```