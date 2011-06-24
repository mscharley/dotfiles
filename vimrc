" Disable vi emulation
set nocompatible

" Setup proper backup handling
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Tab width and other gui stuff
set tabstop=2
set shiftwidth=2
set expandtab
set ruler
set showcmd
set autoindent
set showmatch
set vb t_vb=
set nohls
set incsearch
set backspace=indent,eol,start
set display=lastline
syntax on
filetype on
set ignorecase
set smartcase
set display=lastline
" set mouse=a
set title
set scrolloff=5
set whichwrap+=<,>,[,]

" Line numbers
set number
set numberwidth=6

" Welcome to the real world
set encoding=utf8

" Move up and down by single lines
noremap <Up> gk
noremap! <Up> <C-O>gk
noremap <Down> gj
noremap! <Down> <C-O>gj
" And move the old functionality to alt-arrow
noremap! <M-Up> <Up>
noremap! <M-Down> <Down>
noremap <M-Up> k
noremap <M-Down> j

