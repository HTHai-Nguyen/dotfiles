#!/bin/bash

## List of packages that have been successfully or failed installed
success_list=()
fail_list=()
already_list=()
## Function install packages & log results
install_package() {
  local pkg="$1"
  output=$("$INSTALL_CMD" "$pkg" >/dev/null 2>&1)
  exit_code=$?

  if [[ $exit_code -eq 0 ]] && echo "$output" | grep -Eq "(Installing|Downloading|successfully)"; then
    success_list+=("$pkg")
  elif echo "$output" | grep -Eq "(already installed|no packages needed|nothing to do)"; then
    already_list+=("$pkg")
  else
    fail_list+=("$pkg")
  fi
}

## Install common packages from packages.txt
echo "========================================"
echo "Install common packages"
echo "========================================"
while IFS= read -r line || [[ -n "$line" ]]; do
  line="$(echo "$line" | xargs)"
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  pkg="$(echo "$line" | cut -d' ' -f1)"
  install_package "$pkg"
done <~/dotfiles/scripts/packages.txt

## Oh-my-zsh
# echo "======================"
# echo "Install Oh-my-zsh"
# echo "======================"
# if command -v zsh >/dev/null 2>&1; then
#   if [ ! -f "$HOME/.zshrc" ]; then
#     touch "$HOME/.zshrc"
#     echo "✅ Created .zshrc file"
#   else
#     echo "⚠️ .zshrc already exists, skipping creation"
#   fi
#
#   if [ ! -d "$HOME/.oh-my-zsh" ]; then
#     if yes | KEEP_ZSH=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
#       success_list+=("oh-my-zsh")
#     else
#       fail_list+=("oh-my-zsh")
#     fi
#   else
#     echo "⚠️  Oh My Zsh is already installed. Skipping..."
#   fi
# else
#   echo "❌ zsh is not installed, skipping Oh-my-zsh setup"
#   fail_list+=("oh-my-zsh (skipped due to missing zsh)")
# fi
#
# ## Powerlevel10k
# echo "============================="
# echo "Install Powerlevel10k theme"
# echo "============================="
# P10k="${ZSH_CUSTOM:-$HOME/.oh-my-posh/custom}/themes/powerlevel10k"
# if [ -d "$P10k" ]; then
#   echo "✅ Powerlevel10k is already installed. Skipping installation ..."
# else
#   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# fi
#
# ## Plugins oh-my-posh: autosuggestions, syntax, autocomplete
# echo "=================================================================="
# echo "Install autosuggestion, syntax highlighting, autocomplete for zsh"
# echo "=================================================================="
# if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}" ]; then
#   if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
#     echo "✅ zsh-autosuggestions already installed. Skipping..."
#   else
#     git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#   fi
#   if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" ]; then
#     echo "✅ fast-syntax-highlighting already installed. Skipping..."
#   else
#     git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
#   fi
#   if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]; then
#     echo "✅ zsh-autocomplete already installed. Skipping..."
#   else
#     git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
#   fi
#   echo "✅ zsh plugins installed."
# else
#   echo "⚠️  Oh-my-zsh has not installed."
# fi

## Summary
echo "=================================="
echo "📦 Installation Summary"
echo "=================================="
## success_list
if [ ${#success_list[@]} -gt 0 ]; then
  echo "✅ Installed successfully:"
  for pkg in "${success_list[@]}"; do
    echo "   - $pkg"
  done
else
  echo "⚠️  No packages installed successfully."
fi

# already_list
echo
if [ ${#already_list[@]} -gt 0 ]; then
  echo "✅ Installed already:"
  for pkg in "${already_list[@]}"; do
    echo "   - $pkg"
  done
else
  echo "No packages installed already."
fi

# fail_list
if [ ${#fail_list[@]} -gt 0 ]; then
  echo "❌ Failed to install:"
  for pkg in "${fail_list[@]}"; do
    echo "   - $pkg"
  done
else
  echo "🎉 No failed packages. All done!"
fi
