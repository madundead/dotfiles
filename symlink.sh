#!/bin/sh

for dir in $(ls -d */); do stow -Rv ${dir}; done

# Link planck config to QMK (prime)
ln -s /Users/madundead/Development/dotfiles/planck/keymap.c  /Users/madundead/Development/qmk/keyboards/planck/keymaps/madundead/keymap.c
