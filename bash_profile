export HISTFILESIZE=32768
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

source ~/.git-prompt.sh
source ~/.bash_colors

Time12h="\T"
Time12a="\@"
PathFull="\w"
PathShort="\W"

export PS1=$IBlack$Time12h$Color_Off'$(
if [ -d ".git" ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    echo "'$Red'"$(__git_ps1 " (%s)"); \
  fi) '$Purple$PathFull$Color_Off' \$ "; \
else \
  echo " '$Purple$PathShort$Color_Off' \$ "; \
fi)'