{ ... }:
{
  programs.git = {
    enable = true;

    # Minimal, safe defaults
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
