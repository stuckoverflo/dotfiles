#!/usr/bin/env zsh

# install brew if it doesn't exist
if ! command -v brew > /dev/null 2>&1; then
  printf "\nInstalling Brew\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew analytics off
fi
brew update
brew upgrade

# install source-controlled taps
comm -23 <(sort $0:a:h/brew.txt) <(brew ls --full-name) | xargs brew install
comm -23 <(sort $0:a:h/cask.txt) <(brew cask ls | sed -e '') | xargs brew cask install

brew cleanup

# update brew.txt and cast.txt
brew leaves > $0:a:h/brew.txt
brew cask ls | sed -e '' > $0:a:h/cask.txt
