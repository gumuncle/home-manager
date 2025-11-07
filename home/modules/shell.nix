{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" "sudo" ];
    };
    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      py = "python3";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "/run/current-system/sw/bin"
  ];
}

