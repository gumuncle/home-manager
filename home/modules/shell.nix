{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "";                # テーマによるPROMPT上書きを無効化
      plugins = [ "git" "z" "sudo" ];
    };

    shellAliases = {
      ".." = "cd ..";
      ",," = "cd ../..";
      ll = "ls -lah";
      py = "python3";
    };


    initContent = ''
      autoload -Uz vcs_info
      precmd_vcs_info() { vcs_info }
      precmd_functions+=( precmd_vcs_info )

      GET_RANDOM_EMOJI() {
        local emojis=("🔥" "⚡️" "🚀" "🎧" "🦅" "🐍" "💎")
        echo ''${emojis[''$RANDOM % ''${#emojis[@]}]}
      }

      PROMPT='%F{white}┌───=[ ''${RANDOM##*}$(GET_RANDOM_EMOJI) %n::%F{white}%m%f%F{white}]-[%~]-[%D-%*] %F{white}$vcs_info_msg_0_%f
    %F{white}└──$%f'
    '';




  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      GET_RANDOM_EMOJI() {
        local emojis=("🔥" "⚡️" "🚀" "🎧" "🦅" "🐍" "💎")
        echo ''${emojis[''$RANDOM % ''${#emojis[@]}]}
      }
      PS1="\[\e[97m\]┌───=[ \$RANDOM\$(GET_RANDOM_EMOJI) \u::\h]-[\w]-[\D{%H:%M}] \[\e[97m\]\n└──\$\[\e[0m\] "
    '';
  };

  home.packages = with pkgs; [
    zsh
  ];

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
