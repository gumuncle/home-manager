{ pkgs, ... }:
{
  imports = [
    ./nixvim.nix
    ./shell.nix
    ./git.nix
  ];

  home.username = "gumuncle";
  home.homeDirectory = "/Users/gumuncle";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  targets.darwin = {
    linkApps.enable = false;
    copyApps.enable = false;
  };
}
