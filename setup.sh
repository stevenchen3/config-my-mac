#!/usr/bin/env bash

install_package() {
  if ! package_loc="$(type -p "$1")" || [ -z "$package_loc" ]; then
    echo "Installing '$2'"
    "$3"
  else
    echo "$2 has been installed, '`which $1`', skip installing $2"
  fi
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Install `Homebrew`
install_package brew Homebrew install_homebrew
