## Yet Another Dotfiles

Trying to make my switch to new machines a lot easier...

macOS, zsh + oh-my-zsh, tmux, vim, Ghostty.

### New machine

```sh
git clone https://github.com/junhan-z/dotfiles.git ~/projects/dotfiles
~/projects/dotfiles/install.sh
```

Every step is prompted, so you can take the config links and skip the
toolchains. `--yes` answers yes to everything for an unattended run.

The script is safe to re-run. Links that already point at the right file
are skipped, and anything else in the way is renamed to
`<name>.backup.<timestamp>` rather than deleted — nothing is overwritten
silently.

### What goes where

| Source | Symlinked to |
| --- | --- |
| `configs/<name>` | `~/.<name>` — zshrc, gitconfig, tmux.conf, vimrc, vim/ |
| `ghostty/config` | `~/.config/ghostty/config` |
| `themes/nahnuj.zsh-theme` | `$ZSH_CUSTOM/themes/` |

They are symlinks, so editing `~/.zshrc` edits the file in this repo.
Commit from here.

`Brewfile` lists only what these configs need to work — fnm, fzf, libpq,
tmux, ghostty. Project toolchains stay out of it on purpose, which is
also why `brew bundle dump` is the wrong way to update it: that would
overwrite the list with everything on the machine.

`win_configs/` is Windows Terminal + PowerShell, applied by hand.

### Day to day

```sh
brew bundle --file=Brewfile   # install what is listed
./install.sh                  # re-link after adding a config
```

### Uninstall

`uninstall.sh` removes the symlinks. Note it hardcodes its file list
instead of reading `configs/`, and it also deletes `~/.oh-my-zsh`
outright — read it before running.
