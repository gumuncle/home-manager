{ ... }:
{
  programs.git = {
    enable = true;

    userName = "gumuncle";
    userEmail = "littlefive.jp@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
