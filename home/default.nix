{ pkgs, ... }:
{
  imports = [
    ./nixvim.nix
    ./shell.nix
    ./git.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionPath = [ "$HOME/.nix-profile/bin" ];

  home.shellAliases = {
    ".." = "cd ..";
    ",," = "cd ../..";
  };

  targets.darwin = {
    linkApps.enable = false;
    copyApps.enable = false;
  };
}
