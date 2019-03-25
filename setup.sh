#!/usr/bin/env bash

set -x

GREEN='\033[0;32m'
NC='\033[0m' # No Color

CHECKED_FLAG="${GREEN}[OK]${NC} "

# Install `xcode` command line and development tools
install_xcode() {
  if ! xcode_path="$(xcode-select -p)" || [ -z "${xcode_path}" ]; then
    echo "Installing Xcode Command Line Tools"
    xcode-select --install # git and other development tools will be installed
    git --version          # verify installation and accept license terms
  else
    printf "${CHECKED_FLAG}Xcode developer tools have been installed, skip installing xcode\n"
  fi
}

# Install command line tool
install_package() {
  local cmd=$1
  local name=$2
  local install_cmd=$3

  if ! installed_path="$(type -p "${cmd}")" || [ -z "${installed_path}" ]; then
    echo "Installing '${name}'"
    eval ${install_cmd}
  else
    printf "${CHECKED_FLAG}${name} has been installed, '`which ${cmd}`', skip installing ${name}\n"
  fi
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Config `vim`
configure_vim() {
  local vimrc_conf="$HOME/.vimrc"
  local vimrc_local="$HOME/.vimrc.local"
  local vimrc_bundles="$HOME/.vimrc.bundles"

  backup_file "${vimrc_conf}"    && cp ./vim/vimrc ${vimrc_conf}
  backup_file "${vimrc_local}"   && cp ./vim/vimrc.local ${vimrc_local}
  backup_file "${vimrc_bundles}" && cp ./vim/vimrc.bundles ${vimrc_bundles}
  local clang_release_date=`ls -t /usr/local/Cellar/clang-format | awk 'NR==1{print $1}'`
  sed -i '' -e 's/__CHANGEME__/'"${clang_release_date}"'/g' ${vimrc_local} # no backup before replacement
}

# Install `vim` plugins
install_vim_plugins() {
  local vim_d="/usr/local/etc/vim.d"
  local ycm_extra_conf="$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"

  /usr/local/bin/vim -c PluginInstall -c q -c q
  $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer # `cmake` is required
  mkdir -p ${vim_d} && cp ${ycm_extra_conf} ${vim_d}/
}

# Install `vim` as OSX's default one ships with `-clipboard` by using Homebrew, but we need
# `+clipboard` to enable copy to clipboard across terminals
install_and_configure_vim() {
  brew install vim
  # Config git to use customized vim rather than the default `vim`
  git config --global core.editor /usr/local/bin/vim

  # Install vundle
  # git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  install_package vundle vundle "git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim"

  configure_vim       # configure preferences and add vundle plugins
  install_vim_plugins # Depends on vundle
}

backup_file() {
  local file_path=$1

  if [ -f "${file_path}" ]; then
    if [ -f "${file_path}.bak" ]; then
      local ts=$(date '+%Y%M%d%H%m%S')
      mv "${file_path}" "${file_path}.bak.${ts}"
    else
      mv "${file_path}" "${file_path}.bak"
    fi
  fi
}

# Config bash preferences
configure_bash() {
  local bash_conf="$HOME/.bash_profile"
  local bash_conf_local="$HOME/.bash_aliases"

  backup_file "${bash_conf}"       && cp ./bash/bash_profile ${bash_conf}
  backup_file "${bash_conf_local}" && cp ./bash/bash_profile.local ${bash_conf_local}
}

configure_checkstyle() {
  local checkstyle_d="/usr/local/etc/checkstyle.d"
  backup_file "${checkstyle_d}"
  cp -r checkstyle.d ${checkstyle_d}

  local java_checkstyle_script="/usr/local/bin/java-checkstyle"
  backup_file "${java_checkstyle_script}"
  cp ./scripts/java-checkstyle ${java_checkstyle_script}

  local style_wrapper_dir="/usr/local/opt/style"
  backup_file "${style_wrapper_dir}"
  cp -r ./style ${style_wrapper_dir}

  # Create soft links for wrapper scripts
  ln -f -s ${style_wrapper_dir}/bin/* /usr/local/bin/
}

# Install go from official website. See https://golang.org/doc/install
install_golang() {
  local VERSION=${1:-"1.12.1"}
  local OS=${2:-"darwin"}
  local ARCH=${3:-"amd64"}
  curl -L --retry 3 https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz | tar -C /tmp -xzf -
}



######## Main ########
#
install_xcode

# Install `Homebrew`
install_package brew "Homebrew" install_homebrew

# Install `llvm`, `cmake`, `tree`, `wget`
install_package llvm-gcc "LLVM tools" "brew install llvm"
install_package cmake "cmake command" "brew install cmake"
install_package tree "tree command"   "brew install tree"
install_package wget "wget command"   "brew install wget"

install_and_configure_vim
configure_bash

# Install Java JDK 1.8, `google-java-format` requires it
install_package javac "Java 8" "brew cask install java"

# Install style checkers and formatters
install_package clang-format "Clang-format"                "brew install clang-format" # C-family code style check and format
install_package checkstyle "Checkstyle"                    "brew install checkstyle" # Java code style check
install_package google-java-format "Google Java Formatter" "brew install google-java-format" # Java code formatter
install_package scalastyle "Scala Style Checker"           "brew install scalastyle" # Scala code style check
install_package scalariform "Scala Code Formatter"         "brew install scalariform" # Scala code formatter
install_package scalafmt "Scala Code Formatter 'scalafmt'" "brew install --HEAD olafurpg/scalafmt/scalafmt" # Another Scala code formatter
configure_checkstyle

# Install, Scala, SBT
install_package scala Scala   "brew install scala"
install_package sbt SBT       "brew install sbt"

# Install docker
install_package docker "Docker" "brew cask install docker"

# Install golang
install_golang
