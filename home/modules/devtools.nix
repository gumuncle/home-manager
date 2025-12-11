{ pkgs, ... }: {
  # Keep devtool list explicit and minimal; add as needed per user
  home.packages = let
    inherit (pkgs) python313 nodejs_22 jq ripgrep;
  in [
    python313
    nodejs_22
    jq
    ripgrep
  ];
}

