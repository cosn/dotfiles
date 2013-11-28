export GOROOT=/usr/local/go
export GOPATH=$HOME/src/go
export PATH=$PATH:$GOPATH/bin:$HOME/bin:$HOME/.rvm/bin
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

alias ..='cd ..'
alias grep='grep --color'
alias ls='ls -GFh'
alias gh='cd ~/Documents/github'
alias gogh='cd ~/Documents/github/go/src/github.com/cosn'
alias blog='cd ~/Documents/github/cosn.github.io/'
alias emacs='subl'
alias cls='clear'
