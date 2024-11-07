# VI mode
bindkey -v

# GO Application Path
export GOPATH=$HOME/Applications/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Ruby
export GEM_HOME=$HOME/Applications/ruby/gems
export GEM_PATH=$GEM_HOME
export GEM_BIN_DIR=$HOME/Applications/ruby/bin
export PATH=$PATH:$GEM_BIN_DIR


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Alias?
alias vim="nvim"
alias v="nvim"
alias pandoc="pandoc -s -V colorlinks=true -V linkcolor=red -V urlcolor=blue \
-V toccolor=gray --highlight-style=breezedark -V geometry:margin=1in"
