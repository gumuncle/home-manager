{
  description = "Home Manager setup for macOS (Yusuke)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
  in {
    # --- Home Manager構成 ---
    homeConfigurations."yusuke" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/default.nix ];
    };

    # --- devShell（CLI fallback用）---
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.git pkgs.home-manager ];
    };
  };
}

