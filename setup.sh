!#/bin/bash

# Install HomeBrew
/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)" && brew update

# Install Cask
brew tap phinze/homebrew-cask
brew install brew-cask 

# Brews
brew install curl
brew install wget
brew install openssl
brew install ack
brew install gnu-which
brew install readline
brew install git bash-completion

brew install git
brew install mercurial
brew install vim --override-system-vim

brew install go && mkdir -p ~/src/go/{src,bin,pkg}
brew install gdb

brew install node

brew install python --framwework
brew install python3 --framework

curl -L https://get.rvm.io | bash -s stable && source ~/.rvm/scripts/rvm && rvm autolibs packages && rvm install 1.9.3 && rvm install 2.0.0 && rvm use --default 2.0.0

# Brew Casks
brew cask install dropbox
brew cask install google-chrome
brew cask install google-hangouts
brew cask install sublime-eext
brew cask install vlc
brew cask install wireshark 

# Dot Files
cp bash_colors ~/.bash_colors
cp bash_profile ~/.bash_profile
cp git-prompt.sh ~/.git-prompt.sh
cp gitconfig ~/.gitconfig
cp .vimrc ~/.vimrc
cp vim/colors/* ~/.vim/colors/
cp sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Default/Preferences.sublime-settings
cp sublime-user ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
