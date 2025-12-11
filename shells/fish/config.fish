if status is-interactive
    ## source Aliases
    source ~/.config/fish/aliases.fish
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
    alias bat='batcat'
end
