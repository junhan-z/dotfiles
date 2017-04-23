source ~/.vim/configs/appearance.vim
source ~/.vim/configs/editing.vim

set history=1000
set autoread " autoload files after edit
set shortmess=atI " 取消乌干达

set viminfo^=% " remember last time edit place

"
syntax on

"--------------Auto load after save------------------------------------
autocmd! bufwritepost .vimrc source %
