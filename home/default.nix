{ config, pkgs, lib, ... }:

{
  # ユーザー情報はflake.nixで設定されます
  home.stateVersion = "24.05";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/devtools.nix
  ];

  programs.home-manager.enable = true;

  home.packages = [ pkgs.git ];
}
