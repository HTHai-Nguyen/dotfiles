if status is-interactive
    # Commands to run in interactive sessions can go here
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
