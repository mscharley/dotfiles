" Disable vi emulation
set nocompatible

" Setup proper backup handling
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Turn on syntax highlighting
syntax on
filetype plugin indent on

" Welcome to the real world
set encoding=utf8

" Tab handling. 2 tab width, soft-tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Setup status area
set ruler
set showcmd

" UI Stuff
set autoindent   " Use auto-indenting
set showmatch    " Show matching brackets
set vb t_vb=     " Silence screen flashes
set nohls        " Don't highlight searched items
set incsearch    " Incremental search
set backspace=indent,eol,start " Backspace through anything while in insert mode
set display=lastline " Show as much of a line as possible even if no room.
set cursorline   " Highlight current line
set title        " Automatically set title
set scrolloff=5  " Attempt to keep 5 lines of context when scrolling
" set formatoptions=rq " Automatically insert comment leader on return
set whichwrap+=<,>,[,] " Wrap start to end when using cursor keys

" Setup skins
set background=dark
colorscheme elflord

" Case insensitive by default, unless there are caps
set ignorecase
set smartcase

" Enable the mouse
set mouse=a

" Line numbers
set number
set numberwidth=6

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

" Standardise a few things
noremap Y y$
noremap cw vwhc
