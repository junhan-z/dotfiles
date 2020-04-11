if empty(glob("~/.vim/plugged"))
    execute '!mkdir -p ~/.vim/plugged'
endif

call plug#begin('~/.vim/plugged')

"Swag
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='nord'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
Plug 'arcticicestudio/nord-vim'

"Ale for linting
Plug 'w0rp/ale'

" Javascripts
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" Python
Plug 'hdima/python-syntax'
let python_highlight_all = 1
Plug 'nvie/vim-flake8'
autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>

" Jinja
Plug 'lepture/vim-jinja'

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'javascript.jsx', 'php'] }
let g:user_emmet_mode='n'    "only enable normal mode functions.

" CSS
Plug 'hail2u/vim-css3-syntax' 

" 对齐
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"fuzzy serach"
" install.sh is for C extension, which is faster
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
nmap ; :LeaderfBuffer<CR>
nmap <Leader>f :LeaderfFile<CR>
let g:Lf_WindowPosition = 'bottom'
let g:Lf_ShowDevIcons = 0
let g:Lf_DevIconsFont = 'DejaVuSansMono Nerd Font Mono'

" Auto-Complete
"let g:loaded_youcompleteme = 1 " Disable YCM
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

call plug#end()

