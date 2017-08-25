# install prezto
echo "Prepare Prezto's config"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -s .dotfiles/vim "${ZDOTDIR:-$HOME}/.vim"
ln -s .dotfiles/vimrc "${ZDOTDIR:-$HOME}/.vimrc"
ln -s .dotfiles/gitconfig "${ZDOTDIR:-$HOME}/.gitconfig"
