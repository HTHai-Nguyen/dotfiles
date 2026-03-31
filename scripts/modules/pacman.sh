#!/usr/bin/env bash

detect() {
  command -v pacman >/dev/null 2>&1 || return 0
}

echo
echo "=================================="
echo "PACMAN (Arch-based) detected"
echo "=================================="

# Option: sudo or doas
if command -v doas >/dev/null 2>&1; then
    priv="doas"
elif command -v sudo >/dev/null 2>&1; then
    priv="sudo"
else
    priv=""
fi

## Function find all packages isntalled
pkg_installed() {
  local pkg="$1"
  pacman -Qi "$pkg" >/dev/null 2>&1
}

## Call to install.sh
install_package() {
  local pkg="$1"
  if pkg_installed "$pkg"; then
    echo "$pkg already installed!!"
    return 0
  fi 
  $priv pacman -S --needed --noconfirm "$pkg"
  return $?
}

