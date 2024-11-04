# VI mode
bindkey -v

# GO Application Path
export GOPATH=$HOME/Applications/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Alias?
alias vim="nvim"
alias v="nvim"
alias pandoc="pandoc -s -V colorlinks=true -V linkcolor=red -V urlcolor=blue \
-V toccolor=gray --highlight-style=breezedark -V geometry:margin=1in"
