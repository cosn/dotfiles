set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'

call vundle#end()
filetype plugin indent on

set shortmess+=I
set backspace=indent,eol,start
set history=1024
set showcmd
set showmode
set gcr=a:blinkon0
set visualbell
set autoread
set hidden
set noswapfile
set nobackup
set nowb
set title
set ruler

syntax on
colorscheme molokai

set autoindent
set smartindent

set shiftwidth=2 softtabstop=2 tabstop=2
set expandtab
set smarttab
set nowrap
set linebreak

set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=3
set sidescrolloff=5
set sidescroll=1

set foldmethod=indent
set foldnestmax=3
set nofoldenable

nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
nnoremap <Space> :

set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nmap <leader>s<left>  :topleft  vnew<CR>
nmap <leader>s<right> :botright vnew<CR>
nmap <leader>s<up>    :topleft  new<CR>
nmap <leader>s<down>  :botright new<CR>

set pastetoggle=<F2>

if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
set completeopt=menu,menuone
set pumheight=20
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>d <Plug>(go-def)
