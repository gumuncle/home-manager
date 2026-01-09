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

      autoload -Uz colors vcs_info
      colors

      # Git info (show branch as "GIT:<branch>")
      zstyle ':vcs_info:git:*' formats 'GIT:%b'
      zstyle ':vcs_info:*' enable git

      # Track dirty state too
      __git_dirty=""
      precmd() {
        vcs_info
        __git_dirty=""
        if command git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
          if ! git diff --quiet --ignore-submodules -- 2>/dev/null \
          || ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
            __git_dirty="*"
          fi
        fi
      }

      # Cockpit-ish palette (256color)
      local LC_BG1=236
      local LC_BG2=238
      local LC_HUD=119
      local LC_CYAN=81
      local LC_AMBER=214
      local LC_RED=196
      local LC_DIM=244

      RPROMPT="%F{$LC_DIM}%D{%H:%M:%S}%f"

      # Meaningful labeled tabs: NAV/COM/SYS + status (OK / ERR:<code>)
      PROMPT="%K{$LC_AMBER}%F{0}  %f%k%K{$LC_CYAN}%F{0}  %f%k%K{$LC_HUD}%F{0}  %f%k %F{$LC_HUD}%n@%m%f %F{$LC_DIM}%~%f %F{$LC_CYAN}$vcs_info_msg_0_$__git_dirty%f
%F{$LC_AMBER}└─%f%(?.%F{$LC_HUD}OK%f.%F{$LC_RED}ERR:%?%f) %F{$LC_HUD}❯%f "
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

      __lc_git_branch() {
        git symbolic-ref --short HEAD 2>/dev/null
      }

      __lc_prompt() {
        local ec="$?"
        local br="$(__lc_git_branch)"
        local tm="$(date +%H:%M:%S)"

        # 256color cockpit palette
        local nav="\[\e[48;5;214m\]\[\e[30m\]"   # amber bg, black fg
        local com="\[\e[48;5;81m\]\[\e[30m\]"    # cyan bg, black fg
        local sys="\[\e[48;5;119m\]\[\e[30m\]"   # HUD green bg, black fg
        local hud="\[\e[38;5;119m\]"            # HUD green fg
        local cyn="\[\e[38;5;81m\]"             # cyan fg
        local amb="\[\e[38;5;214m\]"            # amber fg
        local red="\[\e[38;5;196m\]"            # red fg
        local dim="\[\e[38;5;244m\]"            # dim grey fg
        local n="\[\e[0m\]"

        local status="$hud""OK""$n"
        if [ "$ec" -ne 0 ]; then status="$red""ERR:$ec""$n"; fi

        local dirty=""
        if [ -n "$br" ]; then
          if ! git diff --quiet --ignore-submodules -- 2>/dev/null \
          || ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
            dirty="*"
          fi
        fi

        local gitseg=""
        if [ -n "$br" ]; then gitseg="GIT:$br$dirty"; fi

        PS1="$nav  .  $n$com     $n$sys  .  $n $hud\u@\h$n $dim\w$n $cyn$gitseg$n $dim$tm$n\n$amb└─$n$status $hud❯$n "
      }

      PROMPT_COMMAND=__lc_prompt
    '';
  };
}
