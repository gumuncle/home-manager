{ ... }: {
  programs.git = {
    enable = true;
    userName = "Yusuke Furukawa";
    userEmail = "littlefive.jp+git@gmail.com";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
    };
  };
}

