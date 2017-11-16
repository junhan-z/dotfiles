if empty(glob("~/.vim/plugged"))
    execute '!mkdir -p ~/.vim/plugged'
endif

call plug#begin('~/.vim/plugged')

"Swag
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='angr'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
Plug 'szorfein/darkest-space'
Plug 'nightsense/office'

" Javascripts
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax'
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

" 对齐
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"fuzzy serach"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>r :Tags<CR>

" File Nav
Plug 'Xuyuanp/nerdtree-git-plugin'
" 保持nerdtree一致
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0

" Auto-Complete
Plug 'Valloric/YouCompleteMe', {'do': './install.py' }

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
let Tlist_Use_Right_Window = 1 " make taglist on the right
let Tlist_WinWidth=40

"Plug 'vim-scripts/Visual-Mark'
"Plug 'vim-scripts/ShowMarks'
"let showmarks_enable=1
"" Ignore help, quickfix, non-modifiable buffers
"let showmarks_ignore_type = "hqm"
"" Hilight lower & upper marks
"let showmarks_hlline_lower = 1
"let showmarks_hlline_upper = 1

call plug#end()

