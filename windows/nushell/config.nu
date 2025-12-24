# config.nu
# version = "0.109.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# You can open this file in your default editor using:
#     config nu
#     config nu --doc | nu-highlight | less -R

# Oh-my-posh
# source ~/.oh-my-posh.nu

# Starship
source ~/.config/starship/starship.nu

# Startup Zoxide
zoxide init nushell | save -f ~/AppData/Roaming/nushell/zoxide.nu
source ~/AppData/Roaming/nushell/zoxide.nu

# ALIASES
alias ll = ls -l 
alias la = ls -la
alias cls = clear
alias lzg = lazygit
alias vi = nvim
alias nureload = exec nu
alias wezconf = nvim ~/.config/wezterm/wezterm.lua

