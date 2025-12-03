#!/usr/bin/env bash

command -v apt >/dev/null 2>&1 || return 0

echo
echo "=================================="
echo "APT (Debian) detected"
echo "=================================="

## Call to install.sh
export INSTALL_CMD="sudo apt install -y"
source ~/dotfiles/scripts/install.sh
