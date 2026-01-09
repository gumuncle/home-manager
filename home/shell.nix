{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # Home Manager session variables (PATH, etc.)
      if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      # Home Manager session variables (PATH, etc.)
      if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };
}
