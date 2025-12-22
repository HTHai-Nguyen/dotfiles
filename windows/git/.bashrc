themeDir="D:/Application/Scoop/apps/oh-my-posh/current/themes/marcduiker.omp.json"
eval "$(oh-my-posh init bash --config $themeDir)"

# Aliases
alias vi='nvim'
alias cls='clear'
alias g='git'
alias bashrc='nvim ~/.bashrc'
alias bashreload='source ~/.bashrc'
alias np='notepad'
alias lzg='lazygit'

# Eza 
alias ll='eza -l --icons --color=auto --color-scale=size --total-size --group-directories-last --no-permissions'
alias la='eza -la --icons --color=auto --color-scale=size --total-size --group-directories-last --no-permissions'
alias ls='eza -G --icons --color=auto --group-directories-last --no-permissions'
alias lt='eza -T -a --icons --color=auto --group-directories-last --no-permissions --hyperlink'

# Zoxide
eval "$(zoxide init bash)"

# fzf
# bind -r '\C-r'
# bind -x '"\C-f": fzf-file-widget'
