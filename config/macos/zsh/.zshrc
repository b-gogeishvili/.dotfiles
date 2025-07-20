# ZSH Setup config
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
zstyle :compinstall filename "/home/$USER/.zshrc"
autoload -Uz compinit
compinit

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/dotfiles/scripts:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto # update automatically without asking

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh

source <(kubectl completion zsh)

export XDG_CONFIG_HOME=$HOME/.config

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export TERM='xterm'
else
  export EDITOR='nvim'
  export TERM='xterm-ghostty'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

alias v="nvim"
alias sv="sudo nvim"

alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias config="git -C $HOME/dotfiles"
alias pandoc="pandoc -s -V colorlinks=true -V linkcolor=red -V urlcolor=blue \
-V toccolor=gray --highlight-style=breezedark -V geometry:margin=1in"

alias zt="cd ~/Documents/zettelkasten"
alias ws="cd ~/workspace"
alias p="cd ~/personal"
alias repos="cd ~/workspace/repos"
alias dots="cd ~/dotfiles"

alias k="kubectl"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/bgogeishvili/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
