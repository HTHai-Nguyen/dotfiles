#!/bin/bash

PACKAGES=(
  #######################
  ### System packages ###
  #######################
  git
  stow
  curl
<<<<<<< HEAD
=======
  wget
>>>>>>> 8847c20e1a964150ff879daec0307d59d0e9af3c
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
<<<<<<< HEAD
  zsh
  # fish
=======
  # zsh
  # nu
  # fish
  # fish-shell    # for Void Linux
>>>>>>> 8847c20e1a964150ff879daec0307d59d0e9af3c
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
<<<<<<< HEAD
  # neofetch  # if pkgman doesn't have fastfetch
  # eza
  # yazi      # preview image not work for alacritty
  # ranger    # for debian/ubuntu
=======
  # neofetch  # if doesn't have fastfetch
  # eza       # better ls
  # yazi      # preview image not work for alacritty
  # ranger    # for debian/ubuntu
  # glow      # preview markdown
  # marksman  # support markdown
>>>>>>> 8847c20e1a964150ff879daec0307d59d0e9af3c

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
<<<<<<< HEAD
  bspwm
  sxhkd # keybinding for bspwm
=======
  # bspwm
  # sxhkd # keybinding for bspwm
>>>>>>> 8847c20e1a964150ff879daec0307d59d0e9af3c
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
