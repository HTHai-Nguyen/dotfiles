#!/usr/bin/env bash

command -v dnf >/dev/null 2>&1 || return 0

echo
echo "======================"
echo "DNF (Fedora) detected"
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

## Call to install.sh
export INSTALL_CMD="sudo dnf install -y"
# source ~/dotfiles/scripts/install.sh
