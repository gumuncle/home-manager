{ pkgs, ... }:
{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;

    # Minimal, safe defaults
    settings = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
