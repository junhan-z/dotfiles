if empty(glob("~/.vim/plugged"))
    execute '!mkdir -p ~/.vim/plugged'
endif

call plug#begin('~/.vim/plugged')

"Swag
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Javascripts
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'javascript.jsx', 'php'] }

" CSS
Plug 'hail2u/vim-css3-syntax' 

" NERDTree and git plugins
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" Edit Nav
Plug 'terryma/vim-multiple-cursors'
"Plug 'Valloric/YouCompleteMe', {'do': './install.py' }

" 对齐
Plug 'junegunn/vim-easy-align'

" File Nav
Plug 'Xuyuanp/nerdtree-git-plugin'
" 保持nerdtree一致
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

Plug 'hhvm/vim-hack'
Plug 'tpope/vim-surround'

Plug 'vim-scripts/taglist.vim'
nnoremap <leader>t :TlistToggle<cr>
let Tlist_Show_One_File=1 " always show taglist of one file
let Tlist_Use_Right_Window = 1 " make tag list on the right
let Tlist_WinWidth=40

Plug 'vim-scripts/Visual-Mark'
call plug#end()

