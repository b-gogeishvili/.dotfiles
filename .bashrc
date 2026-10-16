[[ $- != *i* ]] && return

PATH="$HOME/.local/bin:$HOME/.devcontainers/bin:$PATH"

eval "$(starship init bash)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rw='systemctl --user restart waybar'
alias rhw='systemctl --user restart hyprpaper'
alias rdns='sudo systemctl restart systemd-resolved'

alias ws='cd ~/Workspace/'

alias v="nvim"
alias sv="sudo nvim"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

