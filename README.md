# Home Manager (Flake)

This repository contains my Home Manager configuration managed with Nix flakes.

<img width="820" height="181" alt="スクリーンショット 2026-01-10 8 22 32" src="https://github.com/user-attachments/assets/8cbae248-783d-487b-8098-19a6324159d5" />


## Requirements

- Nix 2.4+ with flakes enabled (`nix-command` and `flakes`).
- Home Manager (used via the flake input).
- macOS Apple Silicon is assumed by default (`system = "aarch64-darwin"`).

## What’s inside

- `flake.nix`: Flake entrypoint exposing `homeConfigurations."gumuncle"`.
- `home/default.nix`: Main Home Manager module.
- `home/nixvim.nix`: Nixvim configuration module.
- `config/`: Additional config files (if any).

## Usage

### Activate (recommended)

From the repo root:

```sh
home-manager switch --flake .#gumuncle
```

If you don’t have a `home-manager` command installed, you can run it via Nix:

```sh
nix run github:nix-community/home-manager -- switch --flake .#gumuncle
```

### Build only (no activation)

```sh
nix build .#homeConfigurations."gumuncle".activationPackage
```

## Updating inputs

Home Manager does not update flake inputs automatically. To update pinned inputs:

```sh
nix flake update
```

Or update a single input:

```sh
nix flake lock --update-input home-manager
```

## Notes

- `nix flake show` may display `homeConfigurations` as `unknown`; this is normal because it’s a set of derivations.
- If you see a “dirty Git tree” warning, it just means you have uncommitted changes.
