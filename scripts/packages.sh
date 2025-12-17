#!/bin/bash

PACKAGES=(
  #######################
  ### System packages ###
  #######################
  git
  stow
  curl
  btop
  # htop
  gnupg
  # ca-certificates # for Debian/Ubuntu
  # tlp
  # tlp-rdw

  #######################
  ### Coding packages ###
  #######################
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

  #############
  ### Tools ###
  #############
  ## General (X11 & Wayland) ##
  tmux
  fzf
  ripgrep
  bat
  zoxide
  aria2
  fastfetch
  # neofetch  # if pkgman doesn't have fastfetch
  # eza
  # yazi      # preview image not work for alacritty
  # ranger    # for debian/ubuntu

  ## For Wayland ##
  # fuzzel
  # rofi-waylan

  ## For X11 ##
  # picom
  # nitrogen
  # rofi
  # flameshot

  #########################
  ### Terminal Emulator ###
  #########################
  # alacritty
  # kitty
  # ghostty
  # wezterm

  ###########################
  ### Window Manager (WM) ###
  ###########################
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

  ##################
  ### Status bar ###
  ##################
  # waybar
  # polybar
  # xmobar

  ########################
  ### Vietnamese input ###
  ########################
  fcitx5
  fctix5-unikey
  # fctix5-bamboo
  fcitx5-configtool
)
