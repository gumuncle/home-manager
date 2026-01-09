{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initContent = ''
      # Prefer Nix profile binaries over system ones (e.g. git)
      export PATH="$HOME/.nix-profile/bin:$PATH"

      # Home Manager session variables (PATH, etc.)
      if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      setopt PROMPT_SUBST

      autoload -Uz vcs_info
      zstyle ':vcs_info:git:*' formats '(%b)'
      precmd() { vcs_info }

      PROMPT='%F{white}┌───=[  %n::%m]-[%~]-[%D-%*] %F{white}$vcs_info_msg_0_%f
%F{white}└──$%f '
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      # Prefer Nix profile binaries over system ones (e.g. git)
      export PATH="$HOME/.nix-profile/bin:$PATH"

      # Home Manager session variables (PATH, etc.)
      if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      # カスタムプロンプト
      PS1="\[\e[97m\]┌───=[  \u::\h]-[\w]-[\D{%H:%M}] \[\e[97m\]\\n└──\$\[\e[0m\] "
    '';
  };
}
