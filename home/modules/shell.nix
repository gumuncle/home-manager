{ pkgs, ... }: 

let
  # 共通の絵文字プロンプト関数
  emojiFunction = ''
    GET_RANDOM_EMOJI() {
      local emojis=("🔥" "⚡️" "🚀" "🎧" "🦅" "🐍" "💎")
      echo ''${emojis[''$RANDOM % ''${#emojis[@]}]}
    }
  '';

  # 共通のシェルエイリアス
  commonAliases = {
    ".." = "cd ..";
    ",," = "cd ../..";
    ll = "ls -lah";
    py = "python3";
  };

  # 共通の環境変数
  commonSessionVariables = {
    EDITOR = "nvim";
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
  };

  # 共通のPATH設定
  commonSessionPath = [
    "$HOME/.nix-profile/bin"
    "/run/current-system/sw/bin"
  ];
in {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "";  # テーマによるPROMPT上書きを無効化
      plugins = [ "git" "z" "sudo" ];
    };

    shellAliases = commonAliases;

    initContent = ''
      # VCS情報の設定
      autoload -Uz vcs_info
      precmd_vcs_info() { vcs_info }
      precmd_functions+=( precmd_vcs_info )

      ${emojiFunction}

      # Nixのgitを優先するためにPATHの先頭に追加
      export PATH="$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"

      # カスタムプロンプト
      PROMPT='%F{white}┌───=[ ''${RANDOM##*}$(GET_RANDOM_EMOJI) %n::%F{white}%m%f%F{white}]-[%~]-[%D-%*] %F{white}$vcs_info_msg_0_%f
    %F{white}└──$%f'
    '';
  };

  programs.bash = {
    enable = true;
    shellAliases = commonAliases;
    
    bashrcExtra = ''
      ${emojiFunction}
      
      # Nixのgitを優先するためにPATHの先頭に追加
      export PATH="$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"

      # カスタムプロンプト
      PS1="\[\e[97m\]┌───=[ \$RANDOM\$(GET_RANDOM_EMOJI) \u::\h]-[\w]-[\D{%H:%M}] \[\e[97m\]\n└──\$\[\e[0m\] "
    '';
  };

  home.packages = with pkgs; [
    zsh
  ];

  home.sessionVariables = commonSessionVariables;
  home.sessionPath = commonSessionPath;
}
