#!/usr/bin/env bash

detect() {
  command -v pacman >/dev/null 2>&1 || return 0
}

echo
echo "=================================="
echo "PACMAN (Arch-based) detected"
echo "=================================="

## Call to install.sh
install_package() {
  sudo pacman -S --noconfirm "$1"
  return $?
}

## Function find all packages isntalled
pkg_installed() {
  local pkg="$1"
  pacman -Qi "$pkg" >/dev/null 2>&1
}
