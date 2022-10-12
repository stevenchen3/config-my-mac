#!/usr/bin/env bash

#set -x

GREEN='\033[0;32m'
NC='\033[0m' # No Color
CHECKED_FLAG="${GREEN}[\xE2\x9C\x94]${NC} "


# Install `xcode` command line and development tools
# - git
install_xcode() {
  if ! xcode_path="$(xcode-select -p)" || [ -z "${xcode_path}" ]; then
    echo "Installing Xcode Command Line Tools"
    xcode-select --install # git and other development tools will be installed
    git --version          # verify installation and accept license terms
  else
    printf "${CHECKED_FLAG}Xcode developer tools have been installed, skip installing xcode\n"
  fi

  local -r git_version=$(git --version)
  printf "${CHECKED_FLAG}Installed git version '${git_version}'\n"
}


# Install command line tool
install_package() {
  declare -r cmd=$1
  declare -r name=$2
  declare -r install_cmd=$3

  if ! installed_path="$(type -p "${cmd}")" || [ -z "${installed_path}" ]; then
    echo "Installing '${name}'"
    eval ${install_cmd}
  else
    printf "${CHECKED_FLAG}${name} has been installed, '$(which ${cmd})', skip installing ${name}\n"
  fi
}


# Backup a file if it already exists
backup_file() {
  declare -r file_path=$1

  if [ -f "${file_path}" ]; then
    # default backup file name
    local dst_path="${file_path}.bak"

    if [ -f "${file_path}.bak" ]; then
      local -r ts=$(date '+%Y%M%d%H%m%S')
      dst_path="${file_path}.bak.${ts}"
    fi

    mv "${file_path}" "${dst_path}"
    echo "Back file ${file_path} to ${dst_path}"
  fi
}


# Install `brew` command and export system envariables to ~/.zshrc
install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  local -r brew_install_path=$(which brew)
  local -r brew_home_dir=$(dirname ${brew_install_path})

  echo "export HOMEBREW_HOME=${brew_home_dir}" >> ${HOME}/.zshrc
  echo "export HOMEBREW_INSTALL_DIR=\${HOMEBREW_HOME}/Cellar" >> ${HOME}/.zshrc
  echo "export PATH=\$PATH:\${HOMEBREW_HOME}/bin" >> ${HOME}/.zshrc

  source ${HOME}/.zshrc
}


# Install scalafmt
# https://scalameta.org/scalafmt/docs/installation.html
install_scalafmt() {
  install_package coursier "coursier" "brew install coursier/formulas/coursier"
  install_package scalafmt "scalafmt" "coursier install scalafmt"
}


# Config `vim`
#
# Dependencies
# - brew
# - clang-format installed by brew
configure_vim() {
  declare -r vimrc_conf="${HOME}/.vimrc"
  declare -r vimrc_local="${HOME}/.vimrc.local"
  declare -r vimrc_bundles="${HOME}/.vimrc.bundles"

  source ${HOME}/.zshrc
  echo "Configuring VIM"

  backup_file "${vimrc_conf}"    && cp ./vim/vimrc         ${vimrc_conf}
  backup_file "${vimrc_local}"   && cp ./vim/vimrc.local   ${vimrc_local}
  backup_file "${vimrc_bundles}" && cp ./vim/vimrc.bundles ${vimrc_bundles}

  local -r clang_release_date=$(ls -t ${HOMEBREW_HOME}/Cellar/clang-format | awk 'NR==1{print $1}')
  sed -i '' -e 's/__CHANGE_ME__/'"${clang_release_date}"'/g' ${vimrc_local} # no backup before replacement
  sed -i '' -e 's/__HOMEBREW_INSTALL_DIR__/'"${HOMEBREW_INSTALL_DIR}"'/g' ${vimrc_local}
}


# Install `vim` plugins
#
# Depends on
# - create_usr_locals
# - install_golang
#
install_vim_plugins() {
  declare -r vim_d="/usr/local/etc/vim.d"
  # 12 Oct 2022
  # - Observe directory change
  declare -r ycm_extra_conf_py="$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"

  # Install plugins to VIM installed via brew in a non-interactive way
  $(brew --prefix vim)/bin/vim -c PluginInstall -c q -c q

  # TODO
  # Figure out how to enable python3 headers for building YCM
  python3-config --include  # YouCompleteMe needs Python3 headers to build

  # Dependencies
  # - We need to install `go` first
  # - We need to use the `vim` that is installed via brew to edit codes to achieve autocompletion
  ${HOME}/.vim/bundle/YouCompleteMe/install.py --clangd-completer --go-completer # `cmake` is required

  mkdir -p ${vim_d} && cp ${ycm_extra_conf_py} ${vim_d}/
}


# Install `vim` as OSX's default one ships with '-clipboard' and '-conceal' by using Homebrew, but
# we need '+clipboard' to enable copy to clipboard across terminals and '+conceal' to use some plugins
install_and_configure_vim() {
  brew install vim

  # get the installation path of vim, e.g., /opt/homebrew/opt/vim
  local -r vim_home=$(brew --prefix vim)

  # Config git to use customized vim rather than the default `vim`
  git config --global core.editor "${vim_home}/bin/vim"

  # Install vundle
  # git clone --recursive https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
  install_package vundle vundle "git clone --recursive https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim"

  configure_vim       # configure preferences and add vundle plugins
  install_vim_plugins # Depends on vundle
}


# Config bash preferences
configure_bash() {
  declare -r bash_conf="${HOME}/.bash_profile"
  declare -r bash_conf_local="$HOME/.bash_aliases"

  backup_file "${bash_conf}"       && cp ./bash/bash_profile ${bash_conf}
  backup_file "${bash_conf_local}" && cp ./bash/bash_profile.local ${bash_conf_local}
}


# Create required directories with sudo and change the ownership to current user
create_usr_locals() {
   mkdir -p /usr/local/etc &&  chown -R $(whoami):staff /usr/local/etc
   mkdir -p /usr/local/opt &&  chown -R $(whoami):staff /usr/local/opt
}


configure_checkstyle() {
  declare -r checkstyle_d="/usr/local/etc/checkstyle.d"
  backup_file "${checkstyle_d}"
  cp -r checkstyle.d ${checkstyle_d}

  declare -r java_checkstyle_script="/usr/local/bin/java-checkstyle"
  backup_file "${java_checkstyle_script}"
  cp ./scripts/java-checkstyle ${java_checkstyle_script}

  declare -r style_wrapper_dir="/usr/local/opt/style"
  backup_file "${style_wrapper_dir}"
  cp -r ./style ${style_wrapper_dir}

  # Create soft links for wrapper scripts
  sudo ln -f -s ${style_wrapper_dir}/bin/* /usr/local/bin/
}


# Install go from official website. See https://golang.org/doc/install
# Alternatively, use 'brew install go', remember to set 'export GOROOT="$(brew --prefix golang)/libexec"'
# and 'export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"' to '$HOME/.bash_aliases'
install_golang() {
  #local VERSION=${1:-"1.12.1"}
  #local OS=${2:-"darwin"}
  #local ARCH=${3:-"amd64"}
  #curl -L --retry 3 https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz | tar -C /usr/local -xzf -

  #install_package go "Go"   "brew install go"
  #install_package dep "Dep" "brew install dep" # dependency manager

  install_package go "Go"   "brew install go@1.16 && brew link --force go@1.16"
}




######### Main ########
##
#install_xcode
#install_homebrew

# Install `Homebrew` install_package brew "Homebrew" install_homebrew

# Install `llvm`, `cmake`, `tree`, `wget`
#install_package llvm-gcc "LLVM tools"    "brew install llvm"
#install_package cmake    "cmake command" "brew install cmake"
#install_package tree     "tree command"  "brew install tree"
#install_package wget     "wget command"  "brew install wget"

# Install Java JDK 1.8, `google-java-format` requires it
#install_package javac "Java 8" "brew cask install java"

# Install style checkers and formatters
#install_package clang-format "Clang-format"                "brew install clang-format"                      # C-family code style check and format
#install_package checkstyle "Checkstyle"                    "brew install checkstyle"                        # Java code style check
#install_package google-java-format "Google Java Formatter" "brew install google-java-format"                # Java code formatter
#install_package scalastyle "Scala Style Checker"           "brew install scalastyle"                        # Scala code style check
#install_package scalariform "Scala Code Formatter"         "brew install scalariform"                       # Scala code formatter
#install_scalafmt # Another Scala code formatter

#create_usr_locals
#configure_checkstyle

#install_and_configure_vim
#configure_bash

# Optional
#
## Install, Scala, SBT
#install_package scala "Scala" "brew install scala"
#install_package sbt "SBT"     "brew install sbt"
#
## Install docker
#install_package docker "Docker" "brew cask install docker"
#
## Install golang
#install_golang
