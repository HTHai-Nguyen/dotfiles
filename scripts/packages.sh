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
  # helix
  # zsh
  # fish
  # nu
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
  # fd        # for rolling release
  fd-find
  # neofetch  # if doesn't have fastfetch
  # eza       # better ls
  # yazi      # preview image not work for alacritty
  # ranger    # for debian/ubuntu
  # glow      # preview markdown
  # marksman  # support markdown

  ## For Wayland ##
  # fuzzel
  # rofi-wayland

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
  bspwm
  sxhkd # keybinding for bspwm
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
  # fcitx5
  # fctix5-unikey
  # fctix5-bamboo
  # fcitx5-configtool

  ###################
  ### Appications ###
  ###################
  # firefox
  # firefox-esr     # firefox stable & less features
)
