"
" The main vim configuration
"
" -----------------------------------------------------------------------------
"
" Vundle configuration (a courtesy of VundleVim), where Vundle is the tool to
" manage Vim plugins
"
" This section is created based on example at
" https://github.com/VundleVim/Vundle.vim#about
"
" !!! This section must be placed on top of this file !!!
"
" Without this vim emits a zero exit status, later, because of :ft off. This is
" recommended for 'git commit' just in case of any vim plugin error
filetype on

set nocompatible       " Do not bother with vi compatibility, REQUIRED
filetype off           " REQUIRED by Vundle

" Set the runtime path to include Vundle and initialize, this is where your Vim
" plugin packages will be stored
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()    " Begin processing plugins
" Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Install Vundle bundles from bundles configuration files. Placing all plugins
" you want to install into '.vimrc.bundles' or '.vimrc.bundles.local' is highly
" recommended. If those files do not exist, just create them
if filereadable(expand('~/.vimrc.bundles'))
  source ~/.vimrc.bundles
endif

" Plugin 'some-org/some-plugin'  "Just an example
"
" Alternatively, you can also include plugins before this line, but is not
" recommended
call vundle#end()      " Required by Vundle

" Ensure ftdetect et al work by including this after the Vundle stuff, REQUIRED
" by Vundle
filetype plugin indent on

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"
" Brief help
"  :PluginList        " List all installed plugins
"  :PluginInstall     " Install plugins
"  :PluginSearch foo  " Search for plugin foo
"  :PluginClean!      " Clean up unused plugins, those not in ~/.vimrc.bundles
"
" see :h vundle for more details
"
" Put other non-plugin related settings after this line
" END OF PLUGIN SETTINGS

" -----------------------------------------------------------------------------
" Enable basic mouse behavior such as resizing buffers
"
" 'a' is for all modes. For other modes, check via :help 'mouse'
set mouse=a
" Support resizing in tmux (terminal multiplexer, e.g., vsplit window)
if exists('$TMUX')
  set ttymouse=xterm2
endif

" -----------------------------------------------------------------------------
" Color scheme settings
"
" Color scheme settings should be prior to other settings related to color,
" it will override other settings otherwise (e.g., cursor line color)
"
" Use 'solarized' for iTerm and use 'desert' for others (e.g., xterm)
if (&t_Co == 256 || has('gui_running'))
  if ($TERM_PROGRAM == 'iTerm.app')
    set background=light
    colorscheme solarized  " Plugin 'vim-scripts/Solarized' REUIRED
  else
    colorscheme desert
  endif
endif

" -----------------------------------------------------------------------------
" General settings
"
" A courtesy of Maximum Awesome (https://github.com/square/maximum-awesome)
"
" OS X Marvericks or later shipped with '-clipboard'. Type '/usr/bin/vim
" --version' to check. To enable this (set clipboard=unnamed), you may need to
" install other distribution vim. Alternatively, you can use 'brew install vim'
" to install, which will be available at '/usr/local/bin/vim'. An alias to this
" vim may be required in your '~/.bash_profile'
"
" If any of the following does not make sense to you, simply comment it out
"
syntax enable          " Enable syntax highlighting
set autoindent         " Enable auto-indentation
set autoread           " Reload files when changed on disk, i.e., via 'git checkout'
set backspace=2        " Fix broken backspace in some setups
set backupcopy=yes     " See :help crontab
set clipboard=unnamed  " Yank and paste with the system clipboard
set directory-=.       " Do not store swapfiles with the current directory
set encoding=utf-8     " Use UTF-8 encoding
set expandtab          " Expend tabs to spaces
set ignorecase         " Case-insensitive search
set incsearch          " Search as you type
set laststatus=2       " Always show status line
set list               " Show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number             " Show line number
"set relativenumber     " Use relative line number
set ruler              " Show where you are
set scrolloff=3        " Show context above/below cursorline
set shiftwidth=2       " Normal mode indentation commands use 2 spaces
set showcmd            " Show commands you have been typing
set smartcase          " Case-sensitive search if any caps
set softtabstop=2      " Insert mode tab and backspace use 2 spaces
set tabstop=8          " Actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc,*.pyc,*.class
set wildmenu           " Show a navigable menu for table completion
" Completion mode that is used for the character specified with 'wildchar'
set wildmode=longest,list,full
set textwidth=100      " Set text width to 100 characters. Line breaks aft 100
set formatoptions+=tc  " Auto-format text and comment according to textwidth
set hlsearch           " Set highlight search result, with default color
set whichwrap+=<,>,h,l,[,]  " Wrap arrow keys between lines
set cursorline         " High light current cursor with dark red (52) color
hi CursorLine cterm=NONE ctermbg=52 ctermfg=white guibg=darkred guifg=white

" -----------------------------------------------------------------------------
" Keyboard shortcuts
"
" 'inoremap': INSERT mode non-recursive mapping
" Shortcut for ESC key, to input characters 'jj', type one by one slowly
" This will be useful for MacBook with touch bar users
inoremap jj <ESC>
" Shortcut for ⇒. This is specially for Scala developers
inoremap => <C-v>u21d2

" -----------------------------------------------------------------------------
" Copy and paste clipboard settings (ctl + c, and ctl + v), Optional
"
"vmap <C-c> "*y        " Yank current selection into system clipboard
"nmap <C-c> "*Y        " Yank current line into system clipboard
"nmap <C-v> "*p        " Paste from system clipboard
"
" Do not copy the contents of an overwritten selection in visual mode
vnoremap p "_dP

" -----------------------------------------------------------------------------
" Git integration settings
"
" Limit commit and merge message line to 72 characters, i.e., git commit
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType gitmerge setlocal spell textwidth=72

" -----------------------------------------------------------------------------
" File type specific settings
"
" REQUIRED to enable auto-formatting for markdown, if plugin
" 'gabrielelana/vim-markdown' is enabled as textwidth is set to 0 by this plugin
au BufRead,BufNewFile *.md setlocal tw=100 spell filetype=markdown

au BufRead,BufNewFile *.fdoc setlocal filetype=yml fo-=t  " Enable YAML file support
autocmd FileType vim setlocal tw=80 formatoptions-=t      " Auto-format comment only
autocmd BufRead,BufNewFile *.txt setlocal spell fo-=c     " Check spelling for '*.txt'
autocmd BufRead,BufNewFile *.sh setlocal fo-=t            " Auto-format comment only
autocmd BufRead,BufNewFile *.py setlocal fo-=t            " Auto-format comment only

" -----------------------------------------------------------------------------
" Other settings
"
" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" -----------------------------------------------------------------------------
" Other customized configuration or plugin specific configuration
"
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  " set autowrite
  source ~/.vimrc.local
endif

