"
"----------------------------------------------------------------------
" edit
set title " change the terminal title

set textwidth=0
set encoding=utf-8

set hidden "allow buffer switching without saving
set nowrap " don't wrap line 
set foldenable
set foldlevel=99

set smartindent
set autoindent

set expandtab
set shiftwidth=2
set softtabstop=2

set ignorecase " ignore case in search
set smartcase

autocmd FileType python,coffee set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType haskell,puppet,ruby,html,css,xml,js set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

set splitright "put to the right of the current
set splitbelow "put :sp to the bottom of the current

set path+=**
set wildmenu

:set noswapfile

"--------------------------------------------------------------------
" key bindings

" some emacs shortcuts
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

imap <C-a> <Home>
imap <C-e> <End>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-d> <Del>
imap <C-h> <BS>
imap jj <ESC>

cmap <C-a> <Home>
cmap <C-e> <End>

" yank to the end of the line
nnoremap Y y$  
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" quick save
map <Esc><Esc> :w<CR>

" enter new line without entering insert mode
nmap <CR> o<Esc>
