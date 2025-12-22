# config.nu
#
# version = "0.109.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# ENVIRONMENTS
$env.config.shell_integration.osc133 = false
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Startup Zoxide
zoxide init nushell | save -f ~/AppData/Roaming/nushell/zoxide.nu
source ~/AppData/Roaming/nushell/zoxide.nu

# ALIASES
alias ll = ls -l 
alias la = ls -la
alias cls = clear
alias lzg = lazygit
alias vi = nvim
