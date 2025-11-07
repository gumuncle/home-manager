# 🏠 Home Manager Setup (macOS, Nix Flake)

This repository contains configuration to build your user environment completely declaratively on macOS using Nix and Home Manager.  
Even basic tools like `git` are provided from the Nix store, so it works even if nothing is installed on macOS itself.

---

## 📦 Overview

- Target OS: macOS (Apple Silicon, `aarch64-darwin`)
- Configuration management: Nix Flake + Home Manager

---

## 🧩 Directory Structure

```
home-manager/
├── flake.nix              # Nix flake definition
├── flake.lock             # Auto-generated (pinned dependencies)
├── home/
│   ├── default.nix        # Home Manager main configuration
│   └── modules/
│       ├── shell.nix      # Zsh settings and PATH
│       ├── git.nix        # Git settings
│       └── devtools.nix   # Development package definitions
├── scripts/
│   └── enter.sh           # Convenience script to launch `nix develop`
└── README.md
```

---

## 🚀 First-Time Setup

1. Install Nix

   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. Apply Home Manager

   ```bash
   nix run nixpkgs#home-manager -- switch --flake .#gumuncle
   ```

3. Verify

   ```bash
   git --version
   # => git version 2.x (from /nix/store/...)
   ```

`git` works even without Xcode Command Line Tools installed on macOS.

---

## ⚙️ Common Commands

| Action | Command |
|------|-----------|
| Apply configuration | `home-manager switch --flake .#yusuke` |
| Test configuration (dry-run) | `home-manager build --flake .#yusuke` |
| Update flake inputs | `nix flake update` |
| Enter a Nix shell | `./scripts/enter.sh` |
| Roll back to a previous generation | `home-manager rollback` |

---

## 🧠 Configuration Highlights

- `flake.nix`  
  → Defines Home Manager and devShell for macOS (`aarch64-darwin`)  
- `home/default.nix`  
  → Imports modules and provides `git` from the Nix store  
- `modules/git.nix`  
  → `programs.git.enable = true;` to declare Git configuration  
- `modules/shell.nix`  
  → Declaratively manage Zsh and environment variables (`home.sessionVariables`)  
- `modules/devtools.nix`  
  → Manage development tools like Python, Node.js, and AWS CLI with Nix  

---

## 🧪 Verification Examples

```bash
# Verify that Nix-managed Git is available in your Zsh environment
echo $PATH | tr ':' '\n' | grep nix
# → If ~/.nix-profile/bin is included, you're good

which git
# → /nix/store/xxxxxx-git-2.x/bin/git
```

---

## 🧰 Examples: Extending the Development Environment

This setup is intentionally simple, but you can extend it in the following ways:

| Goal | Example module |
|------|----------------|
| Manage GUI tools like VSCode | `modules/vscode.nix` |
| Integrate direnv + devShell | `modules/devshell.nix` |
| macOS-specific settings | Conditional: `if pkgs.stdenv.isDarwin then ...` |
| Unified CLI environment | Use `devShells` in `flake.nix` |

---

## 🧾 References

- [Home Manager – nix-community](https://github.com/nix-community/home-manager)
- [NixOS Wiki: Home Manager](https://nixos.wiki/wiki/Home_Manager)
- [Nix Flakes Guide](https://nixos.wiki/wiki/Flakes)
- [Nix on macOS](https://nixos.org/download.html#nix-install-macos)

---

## 📜 License

MIT License  
(c) 2025 Yusuke Furukawa
