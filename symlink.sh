#!/bin/sh

stow -Rv alacritty
stow -Rv tmux
stow -Rv bash
stow -Rv nvim
stow -Rv git
stow -Rv opencode
stow -Rv claude
stow -Rv mise
stow -Rv workmux
stow -Rv pi
stow -Rv scripts

case "$(uname)" in
  "Darwin")
    stow -Rv karabiner
    stow -Rv hammerspoon
    ;;
  "Linux")
    stow -Rv hyprland
    echo "Installing system-level LG TV power-on service..."
    sudo rm -f /etc/systemd/system/lgtv-on.service
    sudo rm -f /etc/systemd/system/multi-user.target.wants/lgtv-on.service
    sudo cp hyprland/.config/systemd/system/lgtv-on.service /etc/systemd/system/lgtv-on.service
    sudo systemctl daemon-reload
    sudo systemctl enable lgtv-on.service
    ;;
esac
