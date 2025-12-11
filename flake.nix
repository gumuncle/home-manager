{
  description = "Home Manager setup for macOS (portable)";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = true;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    # ユーザーごとのHome Manager設定を生成（純粋に定義）
    mkHomeConfiguration = username:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/default.nix
          {
            home.username = username;
            home.homeDirectory = "/Users/${username}";
          }
        ];
      };

    homeConfigurations = {
      cw-yusuke.furukawa = mkHomeConfiguration "cw-yusuke.furukawa";
      gumuncle = mkHomeConfiguration "gumuncle";
    };
  in {
    inherit homeConfigurations;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.git pkgs.home-manager pkgs.nodejs_22 ];
      shellHook = ''
        echo "🏠 Home Manager development environment loaded!"
        echo "👤 Current user: $USER"
        echo "💡 Usage: nix run nixpkgs#home-manager -- switch --flake .#cw-yusuke.furukawa"
      '';
    };
  };
}

