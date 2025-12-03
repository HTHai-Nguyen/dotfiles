#!/usr/bin/env bash
set -xe

# GNU Stow format XDG except .zshrc & .bashrc

set -euo pipefail

# Path setup
rm -rf $HOME/.zshrc
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
HOME_DIR="$HOME"
MODULES_DIR="$DOTFILES_DIR/scripts/modules"

# Detect package manager
PKG_MANGER=""
for m in "$MODULES_DIR"/*.sh; do
  if [ -f "$m" ]; then
    base_name=$(basename "$m" .sh)
    # file_name="${m##*/}"  # If basename command not found
    # base_name="${file_name%.sh}"
    if command -v "$base_name" >/dev/null 2>&1; then
      PKG_MANAGER="$base_name"
      source "$m"
      break
    fi
  fi
done

if [ -z "$PKG_MANAGER" ]; then
  echo "No supported packages manager!"
  exit 1
fi

echo "Module $(basename "$PKG_MANAGER") detected"

# package installed check
installed() {
  local bin="$1"
  command -v "$bin" >/dev/null 2>&1
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
    stow -V "$folder" -d "$DOTFILES_DIR" -t "$target"
    echo "Stowed $folder to $target"
    echo
  else
    echo "Folder $DOTFILES_DIR/$folder nout found. Skipping. "
  fi
}

echo "Symboliclink configs using Stow"
cd "$DOTFILES_DIR"

# keyboards: only kanata
echo "Stow keyboards"
symlink "keyboards/kanata" "$CONFIG_DIR"
echo

# multiplxers
echo "Stow multiplxers"
for mul in multiplxers/*; do
  pkg="$(basename "$mul")"
  if installed "$pkg"; then
    symlink "multiplxers/$pkg" "$CONFIG_DIR"
  else
    echo " - $pkg not installed. Skipping..."
  fi
done
echo

# neovim: select a distribution & uncomment it
# symlink "neomvim/lazyvim" "$CONFIG_DIR"
# symlink "neomvim/nvchad" "$CONFIG_DIR"
# symlink "neomvim/ecovim" "$CONFIG_DIR"
# symlink "neomvim/kickstart" "$CONFIG_DIR"
echo " - Stow neovim/?"
echo

# scripts: ignore
echo "scripts ignore"
echo

# shells: stow all into $HOME
echo "Stow shells"
symlink "shells" "$HOME_DIR"
echo

# statusbars
echo "Stow statusbars"
for bar in statusbars/*; do
  pkg="$(basename "$bar")"
  if installed "$pkg"; then
    symlink "statusbars/$pkg" "$CONFIG_DIR"
  else
    echo " - $pkg not installed. Skipping..."
  fi
done
echo

# terminals
echo "Stow terminals"
for term in terminals/*; do
  pkg="$(basename "$term")"
  if installed "$pkg"; then
    symlink "terminals/$pkg" "$CONFIG_DIR"
  else
    echo " - $pkg not installed. Skipping..."
  fi
done
echo

# tools
echo "Stow tools"
for tool in tools/*; do
  pkg="$(basename "$tool")"
  if installed "$pkg"; then
    symlink "tools/$pkg" "$CONFIG_DIR"
  else
    echo " - $pkg not installed. Skipping..."
  fi
done
echo

# Window manager
echo "Stow window manager"
for wm in WMs/*; do
  pkg="$(basename "$wm")"
  if installed "$pkg"; then
    symlink "Wms/$pkg" "$CONFIG_DIR"
  else
    echo " - $pkg not installed. Skipping..."
  fi
done

echo
echo "All done! Dotilfes successfully GNU Stow."
