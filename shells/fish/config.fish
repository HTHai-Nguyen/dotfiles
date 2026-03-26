if status is-interactive
    export PATH="$PATH:/opt/nvim/"
    set -u fish_greeting "All Hail Kaid Hoang"

    ## Start TMUX
    #    and not set -q TMUX
    #    if tmux has-session -t main 2>/dev/null
    #            tmux attach main
    #    else
    #            tmux new -s main
    #    end
    ## Start zoxide
    zoxide init fish | source

    ## Load Aliases file
    source ~/.config/fish/aliases.fish
    
    ## Aliases common
    alias bat='batcat'
    alias vi='nvim'
    alias mi='micro'
    alias cls='clear'
    alias lzg='lazygit'
    alias fishconf='nvim ~/.config/fish/config.fish'
    alias fishrl='source ~/.config/fish/config.fish'
    alias ..='cd ..'
    alias pd='popd'
    alias download='aria2c -x 16 -s 16'
    #eza
    alias ll='eza -l --icons=always --color=auto --color-scale=size --total-size --group-directories-last --no-permissions'
    alias la='eza -la --icons=always --color=auto --color-scale=size --total-size --group-directories-last --no-permissions'
    alias ls='eza -G --icons=always --color=auto --group-directories-last'
    alias lt='eza -T -a --icons=always --group-directories-last --no-permissions --hyperlink'

    set -Ux FZF_DEFAULT_OPTS "--height=40% --min-height=10 --layout=reverse --border"
end
