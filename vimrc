"This is a comment

"Turning line numbers on
set nu
set relativenumber

"Turning Syntax Highlight on
syntax on

set incsearch
set hlsearch
set foldmethod=indent
set nofoldenable
filetype indent plugin on
set tabstop=4
set shiftwidth=4
set expandtab

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
call plug#end()
