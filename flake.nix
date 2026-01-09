{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
    };

    outputs = { self, nixpkgs, home-manager, nixvim, ... }:
    let
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        homeConfigurations."gumuncle" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./home
                nixvim.homeModules.nixvim
                git
            ];
        };
    };
}