{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };

    # Usage: home-manager switch --flake .#$(whoami) --impure
    outputs = { self, nixpkgs, home-manager, nixvim, ... }:
    let
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
        username = builtins.getEnv "USER";
        homeDirectory = builtins.getEnv "HOME";
    in {
        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./home
                nixvim.homeModules.nixvim
                {
                    home.username = username;
                    home.homeDirectory = homeDirectory;
                }
            ];
        };
    };
}
