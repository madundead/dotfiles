# DOTFILES

## macOS
```bash
# cli tools + rosetta
xcode-select --install
sudo softwareupdate --install-rosetta

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

# tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

$(brew --prefix)/opt/fzf/install # fzf ctrl + r
```

## Arch
TBD
