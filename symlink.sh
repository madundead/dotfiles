#!/bin/sh

stow -Rv alacritty
stow -Rv tmux
stow -Rv bash
stow -Rv nvim
stow -Rv git
stow -Rv opencode

case "$(uname)" in
  "Darwin")
    stow -Rv karabiner
    stow -Rv hammerspoon
    ;;
  "Linux")
    echo "This is Linux"
    ;;
esac
