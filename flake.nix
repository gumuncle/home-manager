{
  description = "Home Manager setup for macOS (portable)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
    
    # ヘルパー関数：ユーザーごとのHome Manager設定を生成
    mkHomeConfiguration = username: 
      let
        # ユーザー名とホームディレクトリを決定
        actualUsername = if username == "default" then "cw-yusuke.furukawa" else username;
        homeDirectory = "/Users/${actualUsername}";
      in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home/default.nix 
          {
            # ユーザー情報を明示的に設定
            home.username = actualUsername;
            home.homeDirectory = homeDirectory;
          }
        ];
      };
    
    # 複数ユーザーをサポートするためのヘルパー
    supportedUsers = [ "default"  "gumuncle" ];
    
    # 動的にhomeConfigurationsを生成
    homeConfigurations = builtins.listToAttrs (
      map (user: {
        name = user;
        value = mkHomeConfiguration user;
      }) supportedUsers
    );
  in {
    # --- 動的Home Manager構成 ---
    inherit homeConfigurations;

    # --- devShell（CLI fallback用）---
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.git pkgs.home-manager ];
      
      # Nixの実験的機能を有効にする環境変数を設定
      shellHook = ''
        export NIX_CONFIG="experimental-features = nix-command flakes"
        echo "🏠 Home Manager development environment loaded!"
        echo "✅ Nix experimental features enabled"
        echo "👤 Current user: $USER"
        echo "💡 Usage: nix run nixpkgs#home-manager -- switch --flake .#$USER"
        echo "💡 Or use default: nix run nixpkgs#home-manager -- switch --flake .#default"
      '';
    };
  };
}

