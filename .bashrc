[[ $- != *i* ]] && return

PATH="$HOME/.local/bin:$PATH"

eval "$(starship init bash)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rw='systemctl --user restart waybar'
alias rhw='systemctl --user restart hyprpaper'
alias rdns='sudo systemctl restart systemd-resolved'

alias v="nvim"
alias vim="nvim"
alias sv="sudo nvim"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

