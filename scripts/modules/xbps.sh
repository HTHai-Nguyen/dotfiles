#!/usr/bin/env bash

detect() {
  command -v xbps-install >/dev/null 2>&1 || return 0
}

echo
echo "=================================="
echo "XBPS (Void-based) detected"
echo "=================================="

## Call to install.sh
install_package() {
  sudo xbps-install -y "$1"
  return $?
}

## Function find all packags installed
pkg_installed() {
  local pkg="$1"
  dpkg -s "$pkg" >/dev/null 2>&1
}
