" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

source ~/.vim/configs/basics.vim
source ~/.vim/configs/plugins.vim

set history=1000
set autoread " autoload files after edit

set viminfo^=% " remember last time edit place

"
syntax on

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"--------------Auto load after save------------------------------------
autocmd! bufwritepost .vimrc source %
