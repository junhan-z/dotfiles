" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

source ~/.vim/configs/basics.vim
source ~/.vim/configs/plugins.vim

" atomake- prefix is for my personal machines
let hostname=system('hostname -s')
if hostname !~ '^[Aa]tomake.*'
  echom join(['Work Mode! Import work configs for', hostname],' ')
  source ~/nahnuj/work_config.vim
endif


" if use solorized in terminal, remember to set the
" terminal colorscheme to be solarized too

set background=dark
colorscheme Tomorrow-Night-Eighties

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"--------------Auto load after save------------------------------------
autocmd! bufwritepost .vimrc source %
