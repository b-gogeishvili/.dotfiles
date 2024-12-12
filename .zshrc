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

# Plugins

# Autosuggestions
source ~/.dotfiles/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Syntax Highlighting
source ~/.dotfiles/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Deno autocompletion
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Scripts
export PATH=$PATH:/home/odin/.scripts

# Alias?
alias vim="nvim"
alias v="nvim"
alias sv="sudo nvim"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias cdcfg="cd /home/odin/.dotfiles/.config"
alias cdnt="cd /home/odin/Documents/Zettelkasten"
alias cdps="cd /home/odin/Workspace/personal"
alias cdtbc="cd /home/odin/Workspace/devops/tbc-academy"

alias config="git -C /home/odin/.dotfiles"
alias pandoc="pandoc -s -V colorlinks=true -V linkcolor=red -V urlcolor=blue \
-V toccolor=gray --highlight-style=breezedark -V geometry:margin=1in"
. "/home/odin/.deno/env"
