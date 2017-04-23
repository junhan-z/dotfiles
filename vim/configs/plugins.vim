if empty(glob("~/.vim/plugged"))
    execute '!mkdir -p ~/.vim/plugged'
endif

call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

call plug#end()
