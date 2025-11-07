{ pkgs, ... }: {
  home.packages = with pkgs; [
    python313
    #nodejs
    jq
    ripgrep
    #gh
    #awscli2
    #docker
    #neovim
  ];
}

