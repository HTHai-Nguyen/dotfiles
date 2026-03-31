#!/usr/bin/env bash

detect() {
  command -v dnf >/dev/null 2>&1 || return 0
}

echo
echo "======================"
echo "DNF (Fedora-based) detected"
echo "======================"

# Option: sudo or doas
if command -v doas >/dev/null 2>&1; then
    priv="doas"
elif command -v sudo >/dev/null 2>&1; then
    priv="sudo"
else
    priv=""
fi

## RPM Fusion
echo
echo "============================="
echo "Check RPM Fusion repository"
echo "============================="
if ! rpm -qa | grep -qw rpmfusion-free-release; then
  echo "📦 Enabling RPM Fusion repository..."
  $priv dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
else
  echo "✅ RPM Fusion repository already enabled. Skipping..."
fi

## Enable COPR
$priv dnf copr enable wezfurlong/wezterm-nightly -y
$priv dnf copr enable alternateved/eza -y
$priv dnf copr enable dejan/lazygit -y
# $priv dnf copr enable -y

## Function find all packages installed
pkg_installed() {
  local pkg="$1"
  dnf list installed "$pkg" >/dev/null 2>&1
}

## Function install package
install_package() {
  local pkg="$1"
  if pkg_installed "$pkg"; then
    echo "$pkg already installed!!"
    return 0
  fi 
  $priv dnf install -y "$pkg"
  return $?
}

