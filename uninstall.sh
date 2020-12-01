UNINSTALL_PATH=$HOME

# remove soft links
rm $UNINSTALL_PATH/.gitconfig
rm $UNINSTALL_PATH/.gitignore_global
rm $UNINSTALL_PATH/.tmux.conf
rm $UNINSTALL_PATH/.vimrc
rm -rf $UNINSTALL_PATH/.vim
rm $UNINSTALL_PATH/.zshrc

# remove oh-my-zsh
rm -rf $UNINSTALL_PATH/.oh-my-zsh
