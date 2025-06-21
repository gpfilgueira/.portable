#!/usr/bin/env bash

set -e

DOTFILES_DIR="${HOME}/.portable"
BACKUP_DIR="${HOME}/.bakconf"

# Ensure backup dir exists
mkdir -p "$BACKUP_DIR"

# Helper: backup + symlink
link_with_backup() {
    local src="$1"
    local dest="$2"
    local name
    name=$(basename "$dest")

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up $dest → $BACKUP_DIR/$name.bak"
        mv -f "$dest" "$BACKUP_DIR/$name.bak"
    fi

    echo "Linking $src → $dest"
    ln -s "$src" "$dest"
}

# Helper: error and usage
usage() {
    echo "Usage: $0 [vim|tmux|bash|git|all]"
    exit 1
}

# Ensure argument is given
[ -z "$1" ] && usage

TOOL="$1"

case "$TOOL" in
  vim)
    echo "Installing Vim/Neovim config..."

    # ~/.vimrc → core.vim
    link_with_backup "$DOTFILES_DIR/vim/core.vim" "$HOME/.vimrc"

    # ~/.config/nvim/init.vim → core.vim
    mkdir -p "$HOME/.config/nvim"
    link_with_backup "$DOTFILES_DIR/vim/core.vim" "$HOME/.config/nvim/init.vim"

    # ~/.vi/plugins.vim → plugins.vim
    mkdir -p "$HOME/.vi"
    link_with_backup "$DOTFILES_DIR/vim/plugins.vim" "$HOME/.vi/plugins.vim"
    ;;

  tmux)
    echo "Installing tmux config..."
    link_with_backup "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    ;;

  bash)
    echo "Installing bash config..."
    for file in bashrc profile inputrc aliases; do
        src="$DOTFILES_DIR/bash/$file"
        dest="$HOME/.$file"
        [ -f "$src" ] && link_with_backup "$src" "$dest"
    done
    ;;

  git)
    echo "Installing git config..."
    link_with_backup "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
    ;;

  all)
    echo "Installing all configs..."
    "$0" vim
    "$0" tmux
    "$0" bash
    "$0" git
    ;;

  *)
    echo "Unknown tool: $TOOL"
    usage
    ;;
esac

echo "Done."
