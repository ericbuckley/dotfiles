# Dotfiles

This repository contains personal configuration files (dotfiles) for a macOS/Linux development environment. It manages configurations for shell, editors, terminals, and other tools using a custom installation script that handles symlinking and initialization.

## Project Structure

The repository is organized into "groups" (directories), each representing a tool or logical collection of configs.

*   **Group Directories:** (e.g., `zsh/`, `nvim/`, `tmux/`) contain the configuration files.
*   **File Mapping:** Files inside a group are mapped relative to the user's home directory (`$HOME`).
    *   Example: `nvim/.config/nvim/init.lua` is symlinked to `~/.config/nvim/init.lua`.
*   **Initialization Scripts:** Files named `init.script` within a group are executed by the installer rather than symlinked.

## Installation

The installation process is automated via `install.sh`.

### Prerequisites
*   **Required:** `git`
*   **Recommended:** `neovim`, `tmux`, `zsh`, `ripgrep`, `python3`

### Run

To install or update the dotfiles:

```bash
./install.sh
```

**Mechanism:**
1.  **Symlinking:** Iterates through all group directories. For each file (excluding `init.script`), it creates a symbolic link in `$HOME` pointing to the file in the repo. It prompts before replacing existing files.
2.  **Initialization:** Finds and executes all `init.script` files found in the repository (e.g., installing zsh antidote, tmux tpm).

## Key Configurations

### Neovim (`nvim/`)
*   **Config:** Lua-based configuration (`init.lua`).
*   **Plugin Manager:** `lazy.nvim` (Automatically bootstrapped).

### Zsh (`zsh/`)
*   **Plugin Manager:** `antidote` (installed via `init.script`).
*   **Prompt:** `pure`.
*   **Features:** `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-eza`, `atuin`.

### Tmux (`tmux/`)
*   **Config:** `.tmux.conf` (Prefix set to `Ctrl-a`).
*   **Plugin Manager:** TPM (Tmux Plugin Manager).
*   **Note:** After the first launch, open a new tmux session and install the TPM plugins using `<ctrl-a> I`.

### Window Management & Terminals
*   **Window Management:** `aerospace` (for macOS tiling).
*   **Terminals:** `alacritty/`, `wezterm/`, `ghostty/`.

## Development Conventions

*   **Adding Configs:** Create a new directory for the tool (if it doesn't exist) and replicate the path structure relative to `$HOME`. Run `./install.sh` to link it.
*   **Scripts:** Use `init.script` for actions that require execution (installing binaries, downloading plugins) instead of just linking.
*   **Idempotency:** The `install.sh` script is designed to be run multiple times safely. It checks if links already exist and match.
