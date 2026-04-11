# Dotfiles

## macOS Setup

### 1. System Requirements
Install Xcode Command Line Tools and Rosetta 2 (for legacy Intel app compatibility):
```bash
xcode-select --install
sudo softwareupdate --install-rosetta
```

### 2. macOS System Tweaks
Apply custom defaults and preferences:
```bash
./macos
```

### 3. Homebrew & Packages
Install Homebrew and restore packages from the `Brewfile`:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install
```

### 4. Application Configurations
Remove the quarantine attribute from Alacritty to allow it to run:
```bash
xattr -dr com.apple.quarantine "/Applications/Alacritty.app"
```

Install useful keybindings and fuzzy completion for `fzf` (e.g., `ctrl-r`):
```bash
$(brew --prefix)/opt/fzf/install
```

### 5. Tmux Setup
Install the Tmux Plugin Manager (TPM). Once installed, open tmux and press `ctrl-a I` to install plugins (or `ctrl-a U` to update):
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

---

## Linux Setup
For Arch Linux installation and system setup, refer to the [arch-install script](https://git.madunde.ad/madundead/arch-install/src/branch/master/install.sh).
