{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER";
  homeDir  = builtins.getEnv "HOME";
in {
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/devtools.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
  ];
}
