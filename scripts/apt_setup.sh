#!/bin/bash

# Always check packages that you want to intall & Linux distros you're using

distro=$(grep '^NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
de="${XDG_CURRENT_DESKTOP:-Unknown DE}"
echo "Automatically setup for $distro ($de)"
echo "======================================"

# Auto update - upgrade & cleanup
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y && sudo apt cleanup -y

# After update, always install git ready for all
echo ""
echo "Install git always is neccessary "
echo "=================================="
if ! command -v git >/dev/null 2>&1; then
    echo "📦 Installing git and base-devel..."
    sudo apt install -y git 
else
    echo "✅ git already installed. Skipping..."
fi

# Check yay for archlinux
# echo ""
# echo "Check yay has already installed"
# echo "==============================="
# if ! command -v yay >/dev/null 2>&1; then
#     echo "🔧 yay not found. Installing yay..."
#     sudo pacman -S --needed -y git 
#     git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay
#     makepkg -si -y
#     cd ~ && rm -rf ~/yay
#     echo "✅ yay install successfull."
# else
#     echo "✅ yay already installed."
# fi

# List of packages that have been successfully or failed installed
success_list=()
fail_list=()

# Function install packages & log results
install_package() {
    pkg=$1
    if sudo apt install -y "$pkg"; then
        success_list+=("$pkg")
    else
        fail_list+=("$pkg")
    fi
}

echo ""
echo "Install system packages"
echo "========================"
system_packages=(
  	curl
    # htop
    btop
    fastfetch
    # neofetch  # for Ubuntu (if not have fastfetch)
    gnupg
    ca-certificates
    build-essential   # for Ubuntu
    software-properties-common  # for Ubuntu
    # firewalld   # for Fedora & Arch
    ufw   # for Ubunu
    refind
    tlp
    tlp-rdw  
)

for pkg in "${system_packages[@]}"; do
    install_package "$pkg"
done

echo ""
echo "Install packages for coding/terminal"
echo "===================================="
coding_packages=(
    neovim
    zsh
    tmux
    fzf # fuzzy find
    zoxide # z jump
    ripgrep # faster grep
    bat  # better cat
    eza  # better ls (not on fedora 42)
    stow
    # i3   # window manager for X11
    # sway # i3-like for wayland
    kitty   # terminal emulator
    # alacritty # terminal emulator minimal & faster
    # wezterm # terminal emulator
    # lazygit
    # mysql 
    # nginx
    # nodejs
    # npm
    # docker
    # postman
    # podman
)

for pkg in "${coding_packages[@]}"; do
    install_package "$pkg"
done

# Install Nerd fonts (DejavuSans Mono)
echo ""
echo "Install Nerd fonts"
echo "=================="
# sudo yay -S -y ttf-dejavu-nerd
# 

echo ""
echo "Install Vietnamese keyboard-layout"
echo "=================================="
vn_packages=(
	fcitx5
	# fcitx5-bamboo   # for wayland
  # fcitx5-unikey   # for X11
	fcitx5-configtool
)

for pkg in "${vn_packages[@]}"; do
	install_package "$pkg"
done

# Install Plank (for GNOME/MATE)
#install_package plank

echo ""
echo "Install Oh-my-zsh"
echo "============================================"
if command -v zsh >/dev/null 2>&1; then
    touch ~/.zshrc
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if yes | KEEP_ZSH=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
            success_list+=("oh-my-zsh")
        else
            fail_list+=("oh-my-zsh")
        fi
    else
        echo "⚠️  Oh My Zsh is already installed. Skipping..."
    fi
else
    echo "❌ zsh is not installed, skipping Oh-my-zsh setup"
    fail_list+=("oh-my-zsh (skipped due to missing zsh)")
fi

echo ""
echo "Install autosuggestion, syntax highlighting, autocomplete for zsh"
echo "================================================================="
if command -v git >/dev/null; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
else
    echo "⚠️  Git has not installed."
fi


echo "=================================="
echo "📦 Installation Summary"
echo "=================================="

if [ ${#success_list[@]} -gt 0 ]; then
    echo "✅ Installed successfully:"
    for pkg in "${success_list[@]}"; do
        echo "   - $pkg"
    done
else
    echo "⚠️  No packages installed successfully."
fi

echo ""

if [ ${#fail_list[@]} -gt 0 ]; then
    echo "❌ Failed to install:"
    for pkg in "${fail_list[@]}"; do
        echo "   - $pkg"
    done
else
    echo "🎉 No failed packages. All done!"
fi

echo "===================================="
echo "Enable packages"
echo "===================================="
sudo systemctl enable tlp
sudo ufw allow ssh
sudo ufw enable
sudo ufw status verbose
sudo refind-install
# neofetch
fastfetch

echo "====================================================================="
echo "Should install Nerd Fonts; Lazyvim & Config file nvim; terminal; zsh; DNS"
echo "Additional packages for customize desktop environments"
echo "======================================================================"

echo "============================================"
echo "Set zsh as default shell "
echo "============================================"
if command -v zsh >/dev/null 2>&1; then
    chsh -s "$(which zsh)"
    echo "✅ zsh set as default shell"
fi 
