#!/bin/bash

PACKAGES=(
  #######################
  ### Driver packages ###
  #######################
  # networkmanager
  # bluez     # bluetooth
  # blueman   # ble with GUI
  # pipewire  # audio driver
  # pipewire-pulse
  # pipewire-alsa
  # pipewire-jack
  # pipewire-bluetooth
  # wireplumber
  # alsa-utils
  # alsa-pipewire
  # alsa-lib
  # sof-firmware
  # libinput              # input for Waland & X11
  # intel-ucode           # Microcode
  # mesa                  # Graphic driver
  # vulkan-intel
  # intel-media-driver
  ##### For Wayland #####
  # wayland
  # wayland-utils
  # xwayland
  # xdg-desktop-portal
  # xdg-desktop-portal-wlr
  # xdg-desktop-portal-kde     # for KDE Plasma
  # wlr-randr
  # wl-clipboard
  # qt6-wayland
  ##### For X11 #####
  # xorg
  # xorg-minimal
  # xorg-server
  # xorg-xinit
  # xinit         # depend on distro
  # xorg-xprop
  # xorg-xset
  # xf86-input-libinput
  # xf86-video-intel
  # xrandr
  # xclip
  # xsel          # lightweight than xclip

  #######################
  ### System packages ###
  #######################
  sudo
  opendoas # better sudo
  git
  stow
  curl
  wget
  7zip
  btop
  # htop
  gnupg
  # arch-keyring    # for Arch
  # ca-certificates # for Debian/Ubuntu
  # tlp
  # tlp-rdw

  #######################
  ### Coding packages ###
  #######################
  neovim
  # helix
  # bash
  # zsh
  # nu            # Nushell
  # fish
  # fish-shell    # for Void Linux
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
  tmux
  fzf
  ripgrep
  bat    # better cat
  zoxide # better cd
  aria2  # better for download
  fastfetch
  # neofetch  # if doesn't have fastfetch
  # fd        # for rolling release
  fd-find
  # eza       # better ls
  trash-cli
  xtools
  # glow      # preview markdown
  # marksman  # support markdown
  ##### For Wayland #####
  # fuzzel
  # rofi-wayland
  ##### For X11 #####
  # picom      # compositor
  # nitrogen   # wallpaper manager
  # feh        # wallpaper manager
  # rofi       # appications launcher
  # flameshot  # screenshot

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
  ##### For Wayland #####
  # hyprland
  # niri
  # sway
  # river
  # mangowc
  # qtile
  ##### For X11 #####
  # i3
  # bspwm
  # sxhkd # keybinding for bspwm
  # awesome
  # xmonad
  # leftwm
  # herbstluftwm
  # dwm
  # sxwm

  ##################
  ### Status bar ###
  ##################
  # waybar
  # polybar
  # xmobar

  #####################
  ### Desktop shell ###
  #####################
  # caelestia-shell
  # noctalia-shell
  # dankmaterialshell

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
  # obs-studio

  ####################
  ### File Manager ###
  ####################
  ##### TUI ######
  # yazi      # preview image not work for alacritty
  # ranger    # should for Debian/Ubuntu
  ##### GUI ######
  # Thunar
  # pcmanfm
  # pcmanfm-qt
  # spacefm
  # Dolphin
)
