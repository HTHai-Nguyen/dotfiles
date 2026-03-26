# Detect Package Manager (PM)

# Option sudo or doas
if type -q doas
  set -g priv 'doas'
else if type -q sudo
  set -g priv 'sudo'
else 
  set -g priv ''
end

# apt (Debian, Ubuntu, LinuxMint)
if type -q apt
  alias install='$priv apt install -y'
  alias update='$priv apt update'
  alias upgrade='$priv apt update -y'
  alias remove='$priv apt remove -y'
  alias uninstall='$priv apt purge -y'
  alias list='apt list'
  function search; apt search $argv | awk '{print $1}'; end

# dnf (Fedora, RHEL, Bazzite)
else if type -q dnf 
  alias install='$priv dnf install -y'
  alias update='$priv dnf update -y'
  alias upgrade='$priv dnf upgrade -y'
  alias remove='$priv dnf remove -y'
  alias uninstall='$priv dnf remove -y'
  function search; dnf search $argv | awk '{print $1}'; end
  
# pacman (Arch, EndeavourOS, CachyOS)
else if type -q pacman
  alias install='$priv pacman -S --no-confirm'
  alias update='$priv pacman -Sy --no-confirm'
  alias upgrade='$priv pacman -Syu --no-confirm'
  alias remove='$priv pacman -R --no-confirm'
  alias uninstall='$priv pacman -Sy --no-confirm'
  function search; pacman -Ss $argv | awk '{print $1}'; end

# xbps (Void Linux)
else if type -q xbps
  alias install='$priv xbps-install -Sy'
  alias update='$priv xbps-install -Sy'
  alias upgrade='$priv xbps-install -Syu'
  alias remove='$priv xbps-remove -Ry'
  alias uninstall='$priv xbps-remove -Ry'
  alias cleanup='$priv xbps-remove -oO'
  function search; xbps-query -Rs $argv | awk '{print $2}'; end

# zypper (OpenSUSE)
else if type -q zypper
  alias install='$priv zypper install -y'
  alias update='$priv zypper refresh -y'
  alias upgrade='$priv zypper update -y'
  alias remove='$priv zypper remove -y'
  alias uninstall='$priv zypper remove -y'
  function search; zypper search $argv | awk '{print $1}'; end

# nix (Nix, NixOS)
else if type -q nix 
  alias ninstall='nix-env -i'
  alias nupdate='nix-channel --update'
  alias nupgrade='nix-env -u'
  alias nremove='nix-env -e'
  alias nuninstall='nix-env -e'
  function search; nix-env -qa $argv | awk '{print $1}'; end

# If the PM is not recognized
else 
  echo "Distro not supported for these aliases"
end
