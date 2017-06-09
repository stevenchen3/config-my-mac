# VIM configuration for Mac OS X

This is my preferred `vim` configuration for development environment. It works good enough for me.
But some of them may not make sense to you, thus, you can remove those. And in this configuration,
I don not use `MacVim` as suggested by
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe#mac-os-x). Instead, I install another
version vim via `brew`.

# Getting Started

Make sure you have the following packages installed and configured properly before proceed to
configure your `vim` environment, if you have not yet done so. Skip otherwise.

+ Latest version `Xcode` and its command line tools (this may take a while)
    - `xcode-select --install` OR
    - install via AppStore
+ Latest version `Homebrew` for package management in `OSX` (see http://brew.sh/ for details)
    - `/usr/bin/ruby -e "$(curl -fsSL
      https://raw.githubusercontent.com/Homebrew/install/master/install)"`
+ Latest version `vim` as `OSX`'s default one ships with `-clipboard`
    - `brew install vim`
+ Latest version `git` and configure git to use the above newly installed `vim`
    - `git config --global core.editor /usr/local/bin/vim`
+ Latest version `cmake` required by `YouCompleteMe` autocompletion
    - `brew install cmake`
+ Latest version `Vundle` to manage `vim` plugins. To install:
    - `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
+ Latest version `clang-format` (required for C-family code formation)
    - `brew install clang-format`
+ Latest version `llvm` (optional)
    - `brew install llvm`

Next, do the following in said order:

+ copy `vimrc` to `~/.vimrc`
+ edit `vimrc.local` by changing `__CHANGEME__` to match the version folder name in
  `/user/local/Cellar/clang-format/`
+ copy `vimrc.local` to `~/.vimrc.local`
+ copy `vimrc.bundles` to `~/.vimrc.bundles`
+ edit `~/.vimrc.bundles` to add or remove plugins (also update plugin settings in `~/.vimrc.local`
  accordingly) based on what you need.
+ launch `vim` and enter `:PluginInstall` to install plugins (it may take a while) OR
    - `vim -c PluginInstall -c q -c q`
+ Open your terminal and do the following (must after installing plugins)
    - `cd ~/.vim/bundle/YouCompleteMe`
    - `./install.py --clang-completer` for C-family syntax support OR `./install.py` without
      C-family syntax support.
+ copy `.ycm_extra_conf.py` to `/usr/local/etc/vim.d` (create this directory if not exist)

Now, you're all set!


# Gotchar

## YouCompleteMe unavailable error

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

appending the following alias to your `~/.bash_profile` may fix your issue

```
   alias vi='/usr/local/bin/vim'
   alias vim='/usr/local/bin/vim'
```

## Change default trigger key for Vim SnipMate plugin

Default trigger key is <TAB> in INSERT mode, however if TAB has been mapped something
else, we need to reset the default trigger key by appending `let g:snips_trigger_key = '<F2>'` to
`~/.vimrc` (In this example, we map to function key F2). However, since `snips_trigger_key` has been
deprecated, after making this change, every time you open vim, you will see annoying message like
`g:snips_trigger_key is deprecated. See :h snipMate-mappings`. To avoid this, please comment the
following line at `~/.vim/bundle/vim-snipmate/after/plugin/snipMate.vim`

```
echom 'g:snips_trigger_key is deprecated. See :h snipMate-mappings'
```

# Acknowledgement

A courtesy of [Maximum Awesome](https://github.com/square/maximum-awesome)
configuration with preferred customization.
