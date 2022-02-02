#!/bin/bash

DOTFILES=(
	.bashrc
	.profile
	.tmux.conf
	.vimrc
)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h "${HOME}/${1}" ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${BASEDIR}/${1} ${dest}
}

# Install Packages
cd $BASEDIR

for file in ${DOTFILES[@]}
do
    linkDotfile $file
done 

# Install Vundle
if [ -d "$HOME/.vim" ]; then
	rm -rf "$HOME/.vim"
fi
mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

# Install TPM
if [ -d "$HOME/.tmux" ]; then
	rm -rf "$HOME/.tmux"
fi
mkdir -p $HOME/.tmux/plugins
cd $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins

source $HOME/.bashrc
