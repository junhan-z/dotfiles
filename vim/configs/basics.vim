"
"----------------------------------------------------------------------
" Basics
set nocompatible

syntax on
set history=1000
set autoread " autoload files after edit, but it doesnt check periodically
set viminfo^=% " remember last time edit place

" Appearance
set term=screen-256color
set shortmess=atI " 取消乌干达
set showmode "display current mode
set title " change the terminal title

" change cursor behavior between main mode and insert mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" don't blink the cursor
set guicursor+=i:blinkwait0
set cursorline " highlight line
set ruler
set cc=80 " colorcolumn: mark the right column 
" I don't use set number, but do need some margin to the left
set foldcolumn=1

set showmatch
set showcmd

set textwidth=0
set encoding=utf-8

set hidden "allow buffer switching without saving
set wrap " wrap line
set foldenable
set foldlevel=99

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set ignorecase " ignore case in search
set smartcase
set nospell


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

" for trailing and spaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"--------------------------------------------------------------------
"autocmds
"
autocmd FileType python,coffee set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType haskell,puppet,ruby,php,html,css,xml,js set tabstop=2 shiftwidth=2 expandtab ai

autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python,ruby,bash nnoremap <buffer> <localleader>c I#<esc>

autocmd FileType php :iabbrev <buffer> iff if ()<left>

au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

"--------------------------------------------------------------------
" key bindings
"
" highlight setup
set hlsearch
set incsearch
highlight Search ctermbg=grey ctermfg=black
autocmd cursorhold * set nohlsearch
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

" some emacs shortcuts
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>

"eliminate the delay
inoremap <special> <Esc> <Esc>hl
inoremap jj <ESC>

" yank to the end of the line
nnoremap Y y$
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" movements
onoremap p i(

" quick save
map <Esc><Esc> :w<CR>

"--------------------------------------------------------------------
" Tricks
" Surround a word with ", ', (, [, {, <
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>< viw<esc>a><esc>hbi<<esc>lel

" Split and tabs
"
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Track old files
nnoremap bo :browse oldfiles<CR>

" Functions

nnoremap <silent> <c-a> :call TogglePaste()<cr>
function! TogglePaste()
    if &paste ==# 0
        execute "set paste"
        echo "paste"
    else
        execute "set nopaste"
        echo "nopaste"
    endif
endfunction
