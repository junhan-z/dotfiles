" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

source ~/.vim/configs/basics.vim
source ~/.vim/configs/plugins.vim

" N/nahnuj- prefix is for my personal machines
let hostname=system('hostname -s')
if hostname !~ '^[Nn]ahnuj.*'
  echom join(['Work Mode! Import work configs for', hostname],' ')
  source ~/nahnuj/work_config.vim
endif

set background=dark
colorscheme Nord

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"--------------Auto load after save------------------------------------
autocmd! bufwritepost .vimrc source %
