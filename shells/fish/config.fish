# Auto login X11
if status is-login
  if test -z "$DISPLAY" -a "XDG_VTNR"=1 
    exec startx
  end
end

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
end
