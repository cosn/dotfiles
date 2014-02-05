" Disable welcome screen
set shortmess+=I

" Indentdation
set shiftwidth=4 softtabstop=4
set smarttab
set expandtab
set smartindent

" File handling
filetype plugin on
"set foldmethod=syntax

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader>/ :let @/ = ""<cr>

" Shed light on hidden things
set list
set listchars=tab:»»,trail:•
set linebreak
set showbreak=?

" Completion
inoremap <Nul> <C-x><C-o>
set completeopt+=longest

" Smart file openning
"map <leader>t :FuzzyFinderTextMate<CR>
"map <leader>r :ruby @finder = nil<CR>
let g:fuzzy_ignore = "*.pyc;*.png;*.jpg;*.gif;*bmp;*.css"

" Force myself to learn to use hjkl for navigation
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>

" Easier window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Convienence mappings
nnoremap <Space> :
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>

" Scrolling
set ruler
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R
set guioptions-=T
set scrolloff=3

" Other
set visualbell t_vb=
"set autoreload

" Insert blank lines without enterting insert mode
" disabled because these break pressing enter in ack
"nmap <S-Enter> O<Esc>
"nmap <CR> o<Esc>

" Remap s/S to surround operations
" :help text-objects
nmap s ys
nmap S yS

" Enable golang plugins
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on
"
