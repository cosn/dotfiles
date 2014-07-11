export HISTFILESIZE=32768
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$HOME/bin:$HOME/.rvm/bin:/usr/local/bin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source ~/.rvm/scripts/rvm
[[ -f "$HOME/.bash_secrets" ]] && source ~/.bash_secrets
[[ -f "$HOME/.git-completion.bash" ]] && source ~/.git-completion.bash

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

alias ..='cd ..'
alias grep='grep --color'
alias ls='ls -GFh'
alias gh='cd ~/Documents/github'
alias gogh='cd ~/src/go/src/github.com/cosn'
alias blog='cd ~/src/cosn.github.io/'
alias emacs='subl'
alias cls='clear'
alias grb='git pull --rebase'
alias gph='git push origin HEAD'

source ~/.git-prompt.sh
source ~/.bash_colors
source ~/.profile

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
