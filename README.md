# VIM configuration for Mac OS X

This is my preferred `vim` configuration for development environment. It works good enough for me.
But some of them may not make sense to you, thus, you can remove those. And in this configuration,
I don not use `MacVim` as suggested by 
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe#mac-os-x). Instead, I install another
version vim via `brew`.

# Getting Started

Make sure you have the following packages installed and configured properly before proceed to
configure your `vim` environment.

+ Latest version `Xcode` and its command line tools (this may take a while)
+ Latest version `Homebrew` for package management in `OSX` (see http://brew.sh/)
+ Latest version `vim` via `brew install vim` as `OSX`'s default one ships with `-clipboard`
+ Latest version `git` and configure git to use the above newly installed `vim`. To configure:
    - `git config --global core.editor /usr/local/bin/vim`
+ Latest version `cmake` (`brew install cmake`) required by `YouCompleteMe` autocompletion
+ Latest version `Vundle` to manage `vim` plugins. To install:
    - `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
+ Latest version `clang-format` (optional, `brew install clang-format`)
+ Latest version `llvm` (optional, `brew install llvm`)

Next, do the following in said order:

+ copy `vimrc` to `~/.vimrc`
+ copy `vimrc.local` to `~/.vimrc.local`
+ copy `vimrc.bundles` to `~/.vimrc.bundles`
+ edit `~/.vimrc.bundles` to add or remove plugins (also update plugin settings in `~/.vimrc.local`
  accordingly) based on what you need.
+ launch `vim` and enter `:PluginInstall` to install plugins (it may take a while)
+ Open your terminal and do the following (must after installing plugins)
    - `cd ~/.vim/bundle/YouCompleteMe`
    - `./install.py --clang-completer` for C-family syntax support OR `./install.py` without
      C-family syntax support.

Now, you're all set!

# Gotchar

If you encounter this following error message:

```
YouCompleteMe unavailable:
dlopen(/usr/local/Cellar/python/2.7.12_2/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-dynload/_io.so,
2): Symbol not found: __PyCodecInfo_GetInc
rementalDecoder
  Referenced from:
  /usr/local/Cellar/python/2.7.12_2/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-dynload/_io.so
    Expected in: flat namespace
     in
     /usr/local/Cellar/python/2.7.12_2/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-dynload/_io.so
```

append the following alias in your `~/.bash_profile` may fix your issue

```
   alias vi='/usr/local/bin/vim'
   alias vim='/usr/local/bin/vim'
```

# Acknowledgement

A courtesy of [Maximum Awesome](https://github.com/square/maximum-awesome)
configuration with preferred customization.
