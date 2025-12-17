#!/usr/bin/env bash

detect() {
  command -v dnf >/dev/null 2>&1 || return 0
}

echo
echo "======================"
echo "DNF (Fedora-based) detected"
echo "======================"

## RPM Fusion
echo
echo "============================="
echo "Check RPM Fusion repository"
echo "============================="
if ! rpm -qa | grep -qw rpmfusion-free-release; then
  echo "📦 Enabling RPM Fusion repository..."
  sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
else
  echo "✅ RPM Fusion repository already enabled. Skipping..."
fi

## Enable COPR
sudo dnf copr enable wezfurlong/wezterm-nightly -y
sudo dnf copr enable alternateved/eza -y
sudo dnf copr enable dejan/lazygit -y
# sudo dnf copr enable -y

## Function install package
install_package() {
  sudo dnf install -y "$1"
  return $?
}

## Function find all packages installed
pkg_installed() {
  local pkg="$1"
  dnf list installed "$pkg" >/dev/null 2>&1
}
