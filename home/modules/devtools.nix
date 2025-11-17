{ pkgs, ... }: {
  home.packages = with pkgs; [
    python313
    nodejs_22
    jq
    ripgrep
    #gh
    #awscli2
    #docker
    #neovim
  ];
}

