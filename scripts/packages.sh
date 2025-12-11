#!/bin/bash

PACKAGES=(
  ### System packages ###
  git
  stow
  curl
  btop
  # htop
  gnupg
  # ca-certificates # for Debian/Ubuntu
  # tlp
  # tlp-rdw

  ### Coding packages ###
  neovim
  zsh
  # fish
  # nodejs
  # npm
  # lazygit
  # docker
  # lazydocker
  # nginx
  # podman

  ### Tools ###
  ## General (X11 & Wayland)
  tmux
  fzf
  ripgrep
  bat
  zoxide
  aria2
  # eza
  fastfetch
  # neofetch  # if pkgman doesn't have fastfetch
  ## For Wayland
  # fuzzel
  ## For X11
  # picom 
  # nitrogen
  # rofi
  # flameshot 

  ### Terminal Emulator ###
  # alacritty
  # kitty
  # ghostty
  # wezterm

  ### Window Manager (WM) ###
  # hyprland
  # niri
  # sway
  # i3
  # bspwm
  # awesome
  # qtile
  # xmonad
  # leftwm
  # herbstluftwm
  # dwm

  ### Status bar ###
  # waybar
  # polybar
  # xmobar

  ### Veitnamese input ###
  fcitx5
  fctix5-unikey
  # fctix5-bamboo
  fcitx5-configtool
)
