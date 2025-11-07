#!/usr/bin/env bash

# GNU Stow format XDG except .zshrc & .bashrc

set -euo pipefail 

rm -rf $HOME/.zshrc
DOTFILES_DIR=$HOME/dotfiles

# shells
stow -d "$DOTFILES_DIR" shells -t $HOME 

# multiplexers
stow -d "$DOTFILES_DIR" multiplexers 

# neovim choose 1 distro & uncomment that
stow -d "$DOTFILES_DIR/neovim" lazyvim
# stow -d "$DOTFILES_DIR/neovim" ecovim
# stow -d "$DOTFILES_DIR/neovim" kickstart
# stow -d "$DOTFILES_DIR/neovim" nvchad

# terminals
stow -d "$DOTFILES_DIR" terminals

# windows managers
stow -d "$DOTFILES_DIR" wm

echo 
echo "All done! Dotilfes successfully GNU Stow."
