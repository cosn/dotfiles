#!/usr/bin/env bash

defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write com.apple.finder AppleShowAllFiles YES
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -x "/opt/homebrew/bin/brew" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

for i in `cat brew.list`; do /opt/homebrew/bin/brew install $i; done

omz reload

stow -v -t ~/ .

if [ ! -h "$HOME/Library/Application Support/Claude/claude_desktop_config.json" ]; then
  ln -s "$PWD/claude_desktop_config.json" "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
fi
