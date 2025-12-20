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

    ## Aliases
    source ~/.config/fish/aliases.fish
    alias bat='batcat'
    alias vi='nvim'
    alias cls='clear'
    alias fishreload='source ~/.config/fish/aliases.fish'
end
