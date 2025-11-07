{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name  = "gumuncle";
      user.email = "littlefive.jp@gmail.com";
      core.editor = "vim";
      pull.rebase = true;
    };
  };
}

