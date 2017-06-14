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

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set ignorecase " ignore case in search
set smartcase

autocmd FileType python,coffee set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType haskell,puppet,ruby,php,html,css,xml,js set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

"autoindent essentially tells vim to apply the indentation of the current line
"to the next (created by pressing enter in insert mode or with O or o in
"normal mode.
"
"smartindent reacts to the syntax/style of the code you are editing
"(especially for C). When having it on you also should have autoindent on.
set autoindent
set smartindent

set splitright "put to the right of the current
set splitbelow "put :sp to the bottom of the current

set path+=**
set wildmenu

set noswapfile

set mouse=a "scroll vim in terminal

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
