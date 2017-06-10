# Configuring Mac for Development

My preferred configuration on MacBook for development.

+ [Development environment configuration](#dev-env-config)
+ [Work tools](#work-tools)
+ [System preferences](#system-preferences)
+ [Terminal preferences](#terminal-preferences)

## Development environment configuration

Configure or install the following if you have not yet done so. Skip steps otherwise. Alternatively,
you may run the `setup.sh` script to do most of the following automatically.

+ Install latest `Xcode` from AppStore (it may take a while) OR
    - `xcode-select --install`
    - `git --version` (verify the installation and accept License terms and conditions)
+ Install Homebrew to manage packages (see http://brew.sh for details)
    - `/usr/bin/ruby -e "$(curl -fsSL
      https://raw.githubusercontent.com/Homebrew/install/master/install)"`
+ Install Java JDK latest version
    - `brew cask install java`
+ Install customized vim if any (e.g., install other distribution on OS X)
    - OS X ships `vim` with `-clipboard` (run `vim --version` to check), however,
      `+clipboard` is required for copying to/pasting from system clipboard in vim. And
      `YouCompleteMe` does not work well with the default vim
    - `brew install vim`
+ Install git command and SSH key (e.g., bitbucket, gitlab, github)
    - Integrate vim-gitgutter plugin that tells the changes of a file (included in vim configuration)
    - Configure the vim installed by brew as the editor `git config --global core.editor
      /usr/local/bin/vim`
+ Install util tools: wget, tree
    - `brew install wget`
    - `brew install tree` # list directory structure
+ Install OpenVPN client (Tunnelblick) and configure VPN (excluded from the `setup.sh`)
    - Download from OpenVPN website (visit https://openvpn.net) OR
    - `brew install openvpn`
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
+ Install LLVM, Cmake
    - `brew install llvm`
    - `brew install cmake` # required to compile `YouCompleteMe` plugin
+ Install Java formatter and checker (checkstyle, Google Java Format)
    - `brew install checkstyle`
    - `brew install google-java-format`
    - Copy directory to `checkstyle.d` to `/usr/local/etc/checkstyle.d`
    - Copy wrapper script `scripts/java-checkstyle` to `/usr/local/bin/java-checkstyle`
+ Install Scala formatter and checker (scalastyle, scalariform, or scalafmt)
    - `brew install scalastyle`
    - `brew install scalariform`
    - `brew install --HEAD olafurpg/scalafmt/scalafmt`
+ Install `ctags` and configure it with vim to index codebase, optional (excluded from the `setup.sh`)
    - Refer to https://andrew.stwrt.ca/posts/vim-ctags/
+ Install `quicklook-json` plugin for JSON preview (optional, excluded from the `setup.sh`), see
  https://github.com/sindresorhus/quick-look-plugins
    - `brew cask install quicklook-json`
+ Install font `Inconsolata` (refer to `fonts`)
+ Configure `~/.bash_profile` (refer to `bash/bash_profile`)
+ Configure vim (See `README.md` directory `vim` for details)

## Work tools

+ Configure work email
+ Install communication tools (e.g., Slack, Skype for Business, WhatsApp)
+ Install notes (e.g., OneNote)
+ Install `MacTex` (optional) for `Tex` projects (e.g., paper writing)
    - See http://www.tug.org/mactex/ for download and installation guide
    - See http://www.tug.org/mactex/sierra.html to tips to fix issues may exist in EI Capitan and
    later
+ Install Google Chrome browser (Chrome is my favourite browser!)
    - `brew cask install google-chrome`

## System preferences
If this is a new computer, there are a couple tweaks I like to make to the System Preferences.
Feel free to follow these, or to ignore them, depending on your personal preferences.

In Apple Icon > System Preferences:

+ `Trackpad` > `Tap to click`
+ `Keyboard` > Key Repeat > Fast (all the way to the right)
+ `Keyboard` > Delay Until Repeat > Short (all the way to the right)
+ `Accessibility` > `Mouse & Trackpad` > `Trackpad options` > Enable dragging: three finger drag

## Terminal preferences

Open `Terminal` > `Preferences`

+ Make `Pro` as default
+ `Text` > Font (Inconsolata, 14 pt)
+ `Window` > Columns: 130, Rows: 36

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
