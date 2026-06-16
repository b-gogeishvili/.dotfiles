[[ $- != *i* ]] && return
eval "$(starship init bash)"

PATH="$HOME/.local/bin:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rw='systemctl --user restart waybar'
alias rhw='systemctl --user restart hyprpaper'

alias v="nvim"
alias sv="sudo nvim"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

