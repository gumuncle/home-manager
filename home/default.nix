{ config, pkgs, ... }:

{
  home.username = "gumuncle";
  home.homeDirectory = "/Users/gumuncle";
  home.stateVersion = "24.05";

  imports = [
    #./modules/shell.nix
    ./modules/git.nix
    ./modules/devtools.nix
  ];

  home.packages = with pkgs; [
    git
  ];

  programs.home-manager.enable = true;
}

