export HISTSIZE=9999
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export GOPATH=$HOME/src/go
export PATH=$GOPATH/bin:$HOME/bin:/usr/local/bin:/usr/local/heroku/bin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

[[ -f "$HOME/.bash_secrets" ]] && source ~/.bash_secrets
[[ -f "$HOME/.git-completion.bash" ]] && source ~/.git-completion.bash

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

alias ..='cd ..'
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias agg='ag --go -S'
alias agr='ag --ruby -S'
alias apiori="curl https://api.stripe.com/healthcheck"
alias be='bundle exec'
alias ber='bundle exec ruby'
alias blog='cd ~/src/cosn.github.io/'
alias gh='cd ~/Documents/github'
alias gith='hub'
alias gogh='cd ~/src/go/src/github.com/cosn'
alias gom='git pull origin master'
alias gp='git pull'
alias gph='git push origin HEAD'
alias gphf='git push -f origin HEAD'
alias gpr='hub pull-request'
alias gprune='git remote prune origin'
alias grb='git pull --rebase origin'
alias grep='grep --color'
alias ls='ls -GFh'
alias p='cd ~/stripe/pay-server'
alias s='cd ~/stripe'

source ~/.git-prompt.sh
source ~/.bash_colors
source ~/.profile

Time12h="\T"
Time12a="\@"
PathFull="\w"
PathShort="\W"

export PS1=$Black$Time12h$Color_Off'$(
if [ -d ".git" ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    echo "'$Red'"$(__git_ps1 " (%s)"); \
  fi) '$BPurple$PathFull$Color_Off' \$ "; \
else \
  echo " '$BPurple$PathShort$Color_Off' \$ "; \
fi)'
