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
brew update

# Install `llvm`, `cmake`, `tree`, `wget`
install_package llvm-gcc LLVM "brew install llvm"
install_package cmake cmake   "brew install cmake"
install_package tree tree     "brew install tree"
install_package wget wget     "brew install wget"

# Install `vim` as OSX's default one ships with `-clipboard`
brew install vim
# Config git to use customized vim
git config --global core.editor /usr/local/bin/vim

backup_file() {
  if [ -f "$1" ]; then
    mv $1 ${1}.bak
  fi
}

# Config bash preferences
bash_conf="$HOME/.bash_profile"
backup_file "${bash_conf}"
cp ./bash/bash_profile ${bash_conf}

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# Install style checkers and formatters
install_package clang-format clang-format                  "brew install clang-format" # C-family code style check and format
install_package checkstyle checkstyle                      "brew install checkstyle" # Java code style check
install_package google-java-format "Google Java Formatter" "brew install google-java-format" # Java code formatter
install_package scalastyle "Scala Style Checker"           "brew install scalastyle" # Scala code style check
install_package scalariform "Scala Code Formatter"         "brew install scalariform" # Scala code formatter
install_package scalafmt "Scala Code Formatter `scalafmt`" "brew install -HEAD olafurpg/scalafmt/scalafmt" # Another Scala code formatter

checkstyle_d="/usr/local/etc/checkstyle.d"
backup_file "$checkstyle_d"
cp -r checkstyle.d ${checkstyle_d}

java_checkstyle_script="/usr/local/bin/java-checkstyle"
backup_file "${java_checkstyle_script}"
cp ./scripts/java-checkstyle ${java_checkstyle_script}

style_wrapper_dir="/usr/local/opt/style"
backup_file "${style_wrapper_dir}"
cp ./style ${style_wrapper_dir}

# Create soft links for wrapper scripts
ln -s ${style_wrapper_dir}/bin/cppstyle /usr/local/bin/cppstyle
ln -s ${style_wrapper_dir}/bin/google-cpp-style /usr/local/bin/google-cpp-style

# Config `vim`
vimrc_conf="$HOME/.vimrc"
vimrc_local="$HOME/.vimrc.local"
vimrc_bundles="$HOME/.vimrc_bundles"
backup_file "${vimrc_conf}"    && cp ./vim/vimrc ${vimrc_conf}
backup_file "${vimrc_local}"   && cp ./vim/vimrc.local ${vimrc_local}
backup_file "${vimrc_bundles}" && cp ./vim/vimrc.bundles ${vimrc_bundles}
clang_release_date=`ls -t /usr/local/Cellar/clang-format | awk 'NR==1{print $1}'`
sed -i -e 's/__CHANGEME__/'"${clang_release_date}"'/g' ${vimrc_local}

# Install `vim` plugins
vim -c PluginInstall
$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
vim_d="/usr/local/etc/vim.d"
mkdir -p ${vim_d} && cp ./vim/.ycm_extra_conf.py ${vim_d}/

# Install `JDK 1.8`, Scala, SBT
install_package java "Java 8" "brew cask install java"
install_package scala Scala   "brew install scala"
install_package sbt SBT       "brew install sbt"

# Install docker
install_package docker "Docker" "brew cask install docker"
