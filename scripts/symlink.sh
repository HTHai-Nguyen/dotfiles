#!/usr/bin/env bash

# GNU Stow format XDG except .zshrc & .bashrc

set -euo pipefail

# Path setup
rm -rf $HOME/.zshrc
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
HOME_DIR="$HOME"
MODULES_DIR="$DOTFILES_DIR/scripts/modules"

# package installed check
is_installed() {
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
  local module_dir="$DOTFILES_DIR/$module"

  [ -d "$module_dir" ] || return

  echo -e "\n📦 Selectively stowing $module"

  # Build ignore regex for packages NOT installed
  local ignore_regex=""
  for pkg_path in "$module_dir"/*; do
    [ -d "$pkg_path" ] || continue
    pkg="$(basename "$pkg_path")"

    if ! is_installed "$pkg"; then
      if [ -z "$ignore_regex" ]; then
        ignore_regex="^$pkg$"
      else
        ignore_regex="$ignore_regex|^$pkg$"
      fi
      echo "⏭ Ignoring $pkg (not installed)"
    else
      echo "✔ Including $pkg"
    fi
  done

  # Unstow first to avoid conflicts
  stow -D "$module" -d "$DOTFILES_DIR" -t "$CONFIG_DIR" >/dev/null 2>&1 || true

  # Stow with --ignore for packages not installed
  if [ -n "$ignore_regex" ]; then
    stow "$module" -d "$DOTFILES_DIR" -t "$CONFIG_DIR" --ignore="$ignore_regex"
  else
    stow "$module" -d "$DOTFILES_DIR" -t "$CONFIG_DIR"
  fi
}

echo "Symboliclink configs using Stow"
cd "$DOTFILES_DIR"

# shells: stow all into $HOME
echo "=====Stow shells====="
if command -v fish >/dev/null 2>&1; then
    echo "Start stow fish to $HOME/.config"
    symlink "shells" "$CONFIG_DIR"
fi
if command -v zsh >/dev/null 2>&1; then
    echo "Start stow zsh to $HOME"
    stow zsh -d ~/dotfiles/shells/ -t "$HOME_DIR"
fi
echo

# keyboards: only kanata (fixed, not auto)
echo "=====Stow keyboards====="
symlink "keyboards" "$CONFIG_DIR"
# if [ -d "$KEYBOARD_DIR/keyboards/kanata" ]; then
#   stow -D "keyboards" -d "$KEYBOARD_DIR" -t "$CONFIG_DIR" >/dev/null 2>&1 || true
#   stow "keyboards" -d "$KEYBOARD_DIR" -t "$CONFIG_DIR" --ignore="config.kbd" --ignore="qmk"
#   echo "Stowed keyboards/kanata → $CONFIG_DIR"
# else
#   echo "keyboards/kanata missing → skipped"
# fi
echo

# multiplexers
echo "=====Stow multiplexers====="
auto_symlink "multiplexers" "$CONFIG_DIR"
echo

# neovim: select a distribution & uncomment it
echo "=====Stow neovim/?====="
# symlink "neomvim/lazyvim" "$CONFIG_DIR"
# symlink "neomvim/nvchad" "$CONFIG_DIR"
# symlink "neomvim/ecovim" "$CONFIG_DIR"
# symlink "neomvim/kickstart" "$CONFIG_DIR"
echo

# statusbars
echo "=====Stow statusbars======"
auto_symlink "statusbars" "$CONFIG_DIR"
echo

# terminals
echo "=====Stow terminals====="
auto_symlink "terminals" "$CONFIG_DIR"
echo

# tools
echo "=====Stow tools====="
auto_symlink "tools" "$CONFIG_DIR"
echo

# Window manager
echo "=====Stow window manager====="
auto_symlink "WMs" "$CONFIG_DIR"

echo
echo "All done! Dotilfes successfully GNU Stow."
