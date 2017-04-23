colorscheme Tomorrow-Night-Eighties 
set term=screen-256color

" change cursor behavior between main mode and insert mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"eliminate the delay
inoremap <special> <Esc> <Esc>hl
" don't blink the cursor
set guicursor+=i:blinkwait0

set cursorline " highlight line
set ruler
set number
set showmatch

set hlsearch
set incsearch

" highlight setup
highlight Search ctermbg=grey ctermfg=black
autocmd cursorhold * set nohlsearch
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

set showmode "display current mode
