if empty(glob("~/.vim/plugged"))
    execute '!mkdir -p ~/.vim/plugged'
endif

call plug#begin('~/.vim/plugged')

" Javascripts
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'javascript.jsx'] }

" CSS
Plug 'hail2u/vim-css3-syntax' 

" NERDTree and git plugins
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()
