# Home Manager (Flake)

This repository contains my Home Manager configuration managed with Nix flakes.

<img width=”820” height=”181” alt=”スクリーンショット 2026-01-10 8 22 32” src=”https://github.com/user-attachments/assets/8cbae248-783d-487b-8098-19a6324159d5” />


## Requirements

- macOS Apple Silicon (`aarch64-darwin`)
- [Nix](https://nixos.org/download/) with `nix-command` and `flakes` enabled

## Usage

### Quick start (any Mac, any username)

```sh
# 1. Install Nix (if not already)
curl --proto ‘=https’ --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone this repo
git clone https://github.com/gumuncle/home-manager.git ~/.config/home-manager
cd ~/.config/home-manager

# 3. Apply — uses your current $USER and $HOME automatically
home-manager switch --flake .#$(whoami) --impure
```

> `--impure` is required because the flake reads `$USER` / `$HOME` from the environment at build time.

### If `home-manager` command is not yet installed

```sh
nix run github:nix-community/home-manager -- switch --flake .#$(whoami) --impure
```

### Build only (no activation)

```sh
nix build --impure .#homeConfigurations.$(whoami).activationPackage
```

## Updating inputs

```sh
# Update all inputs
nix flake update

# Update a single input
nix flake lock --update-input home-manager
```

## What’s inside

| File | Description |
|------|-------------|
| `flake.nix` | Flake entrypoint — picks up username/home from environment |
| `home/default.nix` | Main Home Manager module |
| `home/shell.nix` | zsh / bash configuration |
| `home/git.nix` | Git configuration |
| `home/nixvim.nix` | Nixvim (Neovim) configuration |

## Notes

- `nix flake show` may display `homeConfigurations` as `unknown`; this is normal.
- If you see a “dirty Git tree” warning, it just means you have uncommitted changes.
