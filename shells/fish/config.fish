# Auto login X11
# if status is-login
#   if test -z "$DISPLAY" -a "XDG_VTNR"=1 
#     exec startx
#   end
# end

if status is-interactive
    export PATH="$PATH:/opt/nvim/"
    set -u fish_greeting "All Hail Kaid Hoang"
    set -gx EDITOR nvim

    ## Start TMUX
    #    and not set -q TMUX
    #    if tmux has-session -t main 2>/dev/null
    #            tmux attach main
    #    else
    #            tmux new -s main
    #    end

    ## Autostart
    zoxide init fish | source
    # starship init fish | source

    ## Load Aliases file
    source ~/.config/fish/aliases.fish

    ## Aliases common
    alias vi='nvim'
    alias mi='micro'
    alias cls='clear'
    alias lzg='lazygit'
    alias cm='chezmoi'
    alias fishconf='nvim ~/.config/fish/config.fish'
    alias fishrl='source ~/.config/fish/config.fish'
    alias download='aria2c -x 16 -s 16'
    alias ll='eza -l --icons=always --total-size'
    alias la='eza -la --icons=always --total-size'
    alias ls='eza -G --icons=always'
    alias lt='eza -T -a --icons=always --no-permissions --hyperlink'
end
