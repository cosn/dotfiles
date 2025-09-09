# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="cos"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ":omz:update" mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# VI_MODE_SET_CURSOR=true

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


path=("/opt/homebrew/bin" $path)

plugins=(
  aliases
  asdf
  bazel
  colored-man-pages
  colorize
  command-not-found
  copyfile
  cp
  docker
  direnv
  encode64
  extract
  genpass
  github
  golang
  jsontools
  node
  per-directory-history
  python
  rsync
  safe-paste
  themes
  urltools
  yarn
)

if [[ $OSTYPE == linux* ]]; then
  plugins+=(
    aws
    mosh
    postgres
    screen
    ubuntu
)
elif [[ $OSTYPE == darwin* ]]; then
  plugins+=(
    1password
    brew
    macos
    vscode
)
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export ZSH_DOTENV_FILE=.env.local

  ulimit -n 65536
fi

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ $OSTYPE == linux* ]]; then
  export EDITOR="vim"
  export VISUAL="vim"
elif [[ $OSTYPE == darwin* ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export BAT_THEME="ansi"

  eval "$(zoxide init --cmd cd zsh)"
  eval "$(thefuck --alias ffs)"
  eval "$(fnm env --use-on-cd --shell zsh)"

  path=("/opt/homebrew/opt/postgresql@15/bin" $path)
  path=("/opt/homebrew/opt/gnu-which/libexec/gnubin" $path)
  path=("/opt/homebrew/opt/make/libexec/gnubin" $path)
  path=("$HOME/bin" $path)
  path=("$HOME/.local/bin" $path)
fi

# sources
[[ -s "$(brew --prefix)/share/zsh-syntax-highlighting" ]] && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -s "$(brew --prefix)/share/zsh-autosuggestions" ]] && source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -s "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"
[[ -s "$HOME/.keys" ]] && source "$HOME/.keys"

# completion
if type brew &>/dev/null; then
    fpath=($fpath ~/.zsh/completion)
    fpath=($(brew --prefix)/share/zsh-completions $fpath)

    autoload -Uz compinit
    compinit
  fi

# golang
path=("/usr/local/go/bin" $path)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
path+="$PNPM_HOME"
source <(pnpm completion zsh)

# home assistant
[[ -s "$(brew --prefix)/bin/hass-cli" ]] && source <(_HASS_CLI_COMPLETE=zsh_source hass-cli)

# p10k
[[ -s "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -s "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# git town
source <(git-town completions zsh)

# fuzzy
source <(fzf --zsh)
[[ -s "$HOME/.fzf-git/fzf-git.sh" ]] && source $HOME/.fzf-git/fzf-git.sh

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --style=numbers --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview "dig {}"                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --style=numbers --line-range :500 {}" "$@" ;;
  esac
}

# Graphite
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt

# Accrual
if [[ -d "$HOME/src/accrual" ]]; then
  export AWS_PROFILE=accrual-admin
  path+="$HOME/src/accrual/epsilon/infrastructure/scripts"
fi

#
# opts
#
typeset -U path
path=($^path(N-/))
export PATH

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

bindkey '^y' autosuggest-accept
bindkey '^[y' yank
bindkey '^[k' kill-line

#
# aliases
#
alias gp="git pull"
alias gs="git status"
alias gtmas="gt ma && gt s --stack --update-only"
alias gts="gt sync -f"
alias gtss="gt sync -f && gt s"
alias gph="git push origin HEAD"
alias gphf="git push -f origin HEAD"
alias grb="git pull --rebase origin"

alias pn="pnpm"
alias pnr="pnpm run"
alias pni="pnpm install --recursive"
alias pnu="pnpm update --recursive"
alias pnx="pnpm nx"
alias nb="nx build"
alias nc="nx container"
alias nd="nx dev"
alias nt="nx test"
alias t="turbo"
alias tb="turbo build"
alias td="turbo dev"

alias s="cd ~/src"
alias ae="cd ~/src/accrual/epsilon"
alias aea="cd ~/src/accrual/epsilon/apps"
alias aep="cd ~/src/accrual/epsilon/packages"
alias aeab="cd ~/src/accrual/epsilon/apps/babylon"
alias aeaf="cd ~/src/accrual/epsilon/apps/firm"
alias aea5="cd ~/src/accrual/epsilon/apps/five"
alias aei="cd ~/src/accrual/epsilon/infrastructure"
alias aeit="cd ~/src/accrual/epsilon/infrastructure/terraform/production"
alias asc="cd ~/src/accrual/stellarcom"
alias rfd="cd ~/src/accrual/decisions"

alias cat="bat"
alias cls="clear"
alias lg="lazygit"
alias ls="eza --icons=auto"
alias lt="yazi"
alias n="nvim"
alias pg="psql -U postgres"
alias python="python3"
alias tls="tmux list-sessions"
