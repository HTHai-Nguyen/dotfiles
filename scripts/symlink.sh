#!/usr/bin/env bash

set -euo pipefail

# GNU Stow format XDG except .zshrc & .bashrc

set -euo pipefail

# Path setup
rm -rf $HOME/.zshrc
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
HOME_DIR="$HOME"
MODULES_DIR="$DOTFILES_DIR/scripts/modules"

# Detect package manager
# PKG_MANGER=""
# for m in "$MODULES_DIR"/*.sh; do
#   if [ -f "$m" ]; then
#     base_name=$(basename "$m" .sh)
#     # file_name="${m##*/}"  # If basename command not found
#     # base_name="${file_name%.sh}"
#     if command -v "$base_name" >/dev/null 2>&1; then
#       PKG_MANAGER="$base_name"
#       source "$m"
#       break
#     fi
#   fi
# done
#
# if [ -z "$PKG_MANAGER" ]; then
#   echo "No supported packages manager!"
#   exit 1
# fi

# package installed check
installed() {
  command -v "$1" >/dev/null 2>&1
  # local pkg="$1"
  # if pkg_installed "$pkg"; then
  #   return 0
  # fi
  # return 1
}

# Function to stow a folder to target
symlink() {
  local folder="$1"
  local target="$2"
  if [ -d "$DOTFILES_DIR/$folder" ]; then
    stow -D "$folder" -d "$DOTFILES_DIR" -t "$target" >/dev/null 2>&1 || true # Unstow to avoid conflict
    stow "$folder" -d "$DOTFILES_DIR" -t "$target"
    echo "Complete stow $folder -> $target"
    echo
  else
    echo "Folder $DOTFILES_DIR/$folder nout found. Skipping. "
  fi
}

auto_symlink() {
  local module="$1"
  local target="$2"
  local subdirs=$(find "$DOTFILES_DIR/$module" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
  for sub in $subdirs; do
    if installed "$sub"; then
      symlink "$module/$sub" "$target"
    fi
  done
}

echo "Symboliclink configs using Stow"
cd "$DOTFILES_DIR"

# shells: stow all into $HOME
echo "=====Stow shells====="
symlink "shells" "$HOME_DIR"
echo

# keyboards: only kanata (fixed, not auto)
echo "=====Stow keyboards====="
symlink "keyboards/kanata" "$CONFIG_DIR"
echo

# multiplexers
echo "=====Stow multiplexers====="
KEYBOARD_DIR="$DOTFILES_DIR/keyboards"
if [ -d "$KEYBOARD_DIR/kanata" ]; then
  stow -D "kanata" -d "$KEYBOARD_DIR" -t "$CONFIG_TARGET" >/dev/null 2>&1 || true
  stow "kanata" -d "$KEYBOARD_DIR" -t "$CONFIG_TARGET"
  echo "✔ Stowed keyboards/kanata → $CONFIG_TARGET"
else
  echo "⚠ keyboards/kanata missing → skipped"
fi
echo

# neovim: select a distribution & uncomment it
echo "=====Stow neovim/?====="
# symlink "neomvim/lazyvim" "$CONFIG_DIR"
# symlink "neomvim/nvchad" "$CONFIG_DIR"
# symlink "neomvim/ecovim" "$CONFIG_DIR"
# symlink "neomvim/kickstart" "$CONFIG_DIR"
echo

# scripts: ignore
echo "=====Scripts ignore====="
echo

# statusbars
echo "=====Stow statusbars======"
auto_symlink "statusbars" "$CONFIG_DIR"
echo

# terminals
echo "Stow terminals"
auto_symlink "terminals" "$CONFIG_DIR"
echo

# tools
echo "Stow tools"
auto_symlink "tools" "$CONFIG_DIR"
echo

# Window manager
echo "Stow window manager"
auto_symlink "WMs" "$CONFIG_DIR"

echo
echo "All done! Dotilfes successfully GNU Stow."
