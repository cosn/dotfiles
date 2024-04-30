# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    ag
    aliases
    asdf
    bazel
    colored-man-pages
    command-not-found
    compleat
    copyfile
    cp
    docker
    dotenv
    encode64
    extract
    fastfile
    genpass
    git
    github
    golang
    history
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
        iterm2
        macos
        vscode
)
    export HOMEBREW_NO_ANALYTICS=1
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ $OSTYPE == linux* ]]; then
	export EDITOR='vim'
elif [[ $OSTYPE == darwin* ]]; then
	path=('/opt/homebrew/opt/gnu-which/libexec/gnubin' $path)
	export EDITOR='nvim'
	export BAT_THEME='TwoDark'
	eval "$(zoxide init --cmd cd zsh)"
	eval "$(thefuck --alias ffs)"
fi

# sources
[[ -s "$(brew --prefix)/share/zsh-syntax-highlighting" ]] && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -s "$(brew --prefix)/share/zsh-autosuggestions" ]] && source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -s "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"
[[ -s "$HOME/.keys" ]] && source "$HOME/.keys"

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
path=("$BUN_INSTALL/bin" $path)

# golang
path=('/usr/local/go/bin' $path)

# pnpm
export PNPM_HOME="/Users/cos/Library/pnpm"
path=("$PNPM_HOME" $path)

# home assistant
[[ -s "$(brew --prefix)/bin/hass-cli" ]] && source <(_HASS_CLI_COMPLETE=zsh_source hass-cli)

# p10k
[[ -s "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -s "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# fuzzy
eval "$(fzf --zsh)"
[[ -s "$HOME/.fzf-git/fzf-git.sh" ]] && source $HOME/.fzf-git/fzf-git.sh

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
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
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --style=numbers --line-range :500 {}" "$@" ;;
  esac
}

# aliases
alias gp='git pull'
alias gph='git push origin HEAD'
alias gphf='git push -f origin HEAD'
alias grb='git pull --rebase origin'
alias gcllm='git diff --minimal --cached | \
    llm -t gitcommit > $(git rev-parse --git-dir)/COMMIT_EDITMSG && \
    git commit --verbose --edit --file=$(git rev-parse --git-dir)/COMMIT_EDITMSG'

alias cat='bat'
alias cls = 'clear'
alias lg='lazygit'
alias ls='eza --icons=auto'
alias python='python3'
