#!/usr/bin/env bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

checked="${GREEN}√${NC}"
# Install `xcode` command line tool first
if ! package_loc="$(xcode-select -p)" || [ -z "$package_loc" ]; then
  echo "Installing Xcode Command Line Tools"
  xcode-select --install
else
  printf "${checked}Xcode developer tools have been installed, skip install xcode\n"
fi

install_package() {
  if ! package_loc="$(type -p "$1")" || [ -z "$package_loc" ]; then
    echo "Installing '$2'"
    "$3"
  else
    printf "${checked}$2 has been installed, '`which $1`', skip installing $2\n"
  fi
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Install `Homebrew`
install_package brew Homebrew install_homebrew
#brew update

# Install `llvm`, `cmake`, `tree`, `wget`
install_package llvm-gcc LLVM "brew install llvm"
install_package cmake cmake "brew install cmake"
install_package tree tree "brew install tree"
install_package wget wget "brew install wget"

# Install `vim` as OSX's default one ships with `-clipboard`
brew install vim
# Config git to use customized vim
git config --global core.editor /usr/local/bin/vim

# Config bash preferences
if [ -f "$HOME/.bash_profile" ]; then
  mv $HOME/.bash_profile $HOME/.bash_profile.bak
fi
cp ./bash/bash_profile $HOME/.bash_profile

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# Install `JDK 1.8`, Scala, SBT
install_package java "Java 8" "brew cask install java"
install_package scala Scala "brew install scala"
install_package sbt SBT "brew install sbt"
