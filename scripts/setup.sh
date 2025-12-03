#!/bin/bash

set -euo pipefail

distro=$(grep '^NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
echo
echo "Automatically setup for $distro"
echo "==============================================="

for m in ~/dotfiles/scripts/modules/*.sh; do
  # [[ "$(basename "$m")" == "install.sh" ]] && continue
  [[ -x "$m" ]] && source "$m"
done

## Stow dotfiles
# source symlink.sh 2>/dev/null || true

echo "======================================"
echo "Finish setup for $distro"
echo "======================================"
if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
elif command -v neofetch >/dev/null 2>&1; then
  neofetch
else
  echo "Neither fastfetch nor neofetch is installed."
fi

echo "============================================"
echo "Set zsh as default shell "
echo "============================================"
if command -v zsh >/dev/null 2>&1; then
  chsh -s "$(which zsh)"
  echo "✅ zsh set as default shell"
fi
