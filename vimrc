set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Bundle 'vim-ruby/vim-ruby'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'

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
set number

syntax enable
set background=dark
"colorscheme molokai
colorscheme solarized

set autoindent
set smartindent

set shiftwidth=2 softtabstop=2 tabstop=2
set expandtab
set smarttab
set nowrap
set linebreak

"set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=3
set sidescrolloff=5
set sidescroll=1

set foldmethod=indent
set foldnestmax=3
set nofoldenable

let mapleader=","
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
nnoremap <Space> :

set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>s<left>  :topleft  vnew<CR>
nnoremap <leader>s<right> :botright vnew<CR>
nnoremap <leader>s<up>    :topleft  new<CR>
nnoremap <leader>s<down>  :botright new<CR>

set pastetoggle=<F2>
set clipboard=unnamed

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
set cursorline
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
set completeopt=menu,menuone
set pumheight=20
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

au FileType go nmap <leader>gor <Plug>(go-run)
au FileType go nmap <leader>gob <Plug>(go-build)
au FileType go nmap <leader>got <Plug>(go-test)
au FileType go nmap <Leader>god <Plug>(go-def)

nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>pa :CtrlP ~/stripe/pay-server/admin<cr>
nmap <leader>pl :CtrlP ~/stripe/pay-server/lib<cr>
nmap <leader>pm :CtrlP ~/stripe/pay-server/manage<cr>
nmap <leader>po :CtrlP ~/stripe/pay-server/ops<cr>
nmap <leader>pt :CtrlP ~/stripe/pay-server/test<cr>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1

map <C-n> :NERDTreeToggle<CR>
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" remove trailing whitespace
au FileType ruby,python,coffeescript,javascript,java au BufWritePre <buffer> :%s/\s\+$//e
