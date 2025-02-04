" === Display and Visual Settings ===
" Line numbers
set nu
set relativenumber

" Syntax and colors
syntax on
set termguicolors
set showmatch          " Show matching brackets/parentheses
set ruler              " Show cursor position
set showcmd            " Show partial commands

" === Search Settings ===
set incsearch         " Incremental search
set hlsearch          " Highlight search results

" === Indentation and Formatting ===
" Basic indentation settings
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
filetype indent plugin on

" Folding settings
set foldmethod=indent
set nofoldenable

" === User Interface ===
set mouse=a           " Enable mouse in all modes
set wildmenu          " Better command completion
set scrolloff=8       " Keep lines visible when scrolling

" === Split Management ===
set splitbelow
set splitright

" === File Management ===
" Persistent undo
set undofile
set undodir=~/.vim/undodir