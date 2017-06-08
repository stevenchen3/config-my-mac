# Configuring Computing Environment on OS X

## Development environment configuration

Configure or install the following if they're not done.

+ Configure `~/.vimrc` (refer to `vim/vimrc`)
+ Configure `~/.bash_profile` (refer to `bash/bash_profile`)
+ Install font `Inconsolata` (refer to `fonts`)
+ Install JDK latest version (download from Oracle official website)
    - Check if `JAVA_HOME` is set in `~/.bash_profile`
+ Install brew (visit http://brew.sh)
    - `/usr/bin/ruby -e "$(curl -fsSL
      https://raw.githubusercontent.com/Homebrew/install/master/install)"`
+ Install customized vim if any (e.g., install other distribution on OS X)
    - OS X shipped `vim` with `-clipboard` (execute command `vim --version` to check), however,
      `+clipboard` is required for copying to/pasting from system clipboard in vim
    - YouCompleteMe does not work well with the default vim
    - `brew install vim`
+ Install git command and SSH key (e.g., bitbucket, gitlab, github)
    - Integrate vim-gitgutter plugin that tells the changes of a file
    - Configure the vim installed by brew as the editor `git config --global core.editor
      /usr/local/bin/vim`
+ Install wget
    - `brew install wget`
+ Install OpenVPN client (Tunnelblick) and configure VPN
    - Download from OpenVPN website (visit https://openvpn.net)
+ Install Scala JDK, SBT (latest version)
    - `brew install scala`
    - `brew install sbt`
+ Install Docker (latest version)
    - Download from Docker official website (visit https://www.docker.com) OR
    - `brew cask install docker`
+ Install C-family formatter and checker (clang llvm)
    - `brew install clang-format`
    - Copy directory `style` to `/usr/local/opt/style`
    - Create soft link: `ln -s /usr/local/opt/style/bin/cppstyle /usr/local/bin/cppstyle`
    - Create soft link: `ln -s /usr/local/opt/style/bin/google-cpp-style
      /usr/local/bin/google-cpp-style`
+ Install latest `Xcode` from AppStore (it may take a while)
    - It should automatically install command-line tools (if not, install them manually)
+ Install LLVM
    - `brew install llvm`
+ Install Java formatter and checker (checkstyle, Google Java Format)
    - `brew install checkstyle`
    - `brew install google-java-format`
    - Copy directory to `checkstyle.d` to `/usr/local/etc/checkstyle.d`
    - Copy wrapper script `scripts/java-checkstyle` to `/usr/local/bin/java-checkstyle`
+ Install Scala formatter and checker (scalastyle, scalariform, or scalafmt)
    - `brew install scalastyle`
    - `brew install scalariform`
    - `brew install -HEAD olafurpg/scalafmt/scalafmt`
+ Configure vim (See `README.md` directory `vim` for details)
    - Install Vundle (refer to https://github.com/VundleVim/Vundle.vim#about)
    - Install cmake `brew install cmake`
    - Install `YouCompleteMe` plugin, see https://github.com/Valloric/YouCompleteMe#mac-os-x
+ Install `ctags` and configure it with vim to index codebase, optional
    - Refer to https://andrew.stwrt.ca/posts/vim-ctags/ (TODO)
+ Install `quicklook-json` plugin for JSON preview (optional), see
  https://github.com/sindresorhus/quick-look-plugins
    - `brew cask install quicklook-json`
+ Install `tree` command line tool to list directory structure
  - `brew install tree`

## Work tools

+ Configure work email
+ Install communication tool (e.g., Slack, Skype for Business, WhatsApp)
+ Install notes (e.g., OneNote)
+ Install `MacTex` (optional) for `Tex` projects (e.g., paper writing)
    - See http://www.tug.org/mactex/ for download and installation guide
    - See http://www.tug.org/mactex/sierra.html to tips to fix issues may exist in EI Capitan and
    later

## Other configurations

+ Install Google Chrome browser

## Gotchars

### Change default trigger key for Vim SnipMate plugin

Default trigger key is <TAB> in INSERT mode, however if TAB has been mapped something
else, we need to reset the default trigger key by appending `let g:snips_trigger_key = '<F2>'` to
`~/.vimrc` (In this example, we map to function key F2). However, since `snips_trigger_key` has been
deprecated, after making this change, every time you open vim, you will see annoying message like
`g:snips_trigger_key is deprecated. See :h snipMate-mappings`. To avoid this, please comment the
following line at `~/.vim/bundle/vim-snipmate/after/plugin/snipMate.vim`

```
echom 'g:snips_trigger_key is deprecated. See :h snipMate-mappings'
```
