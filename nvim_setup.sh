#!/bin/bash
# To remove all installed neovim (used to reinstall all again)
sudo apt remove --purge -y neovim
sudo apt -y autoclean && sudo apt -y autoremove
rm -rf $HOME/.config/nvim $HOME/.config/coc $HOME/.local/share/nvim $HOME/.cache/nvim

# First tasks
dir=$PWD
mkdir -p $HOME/.config/nvim
nvim_configs=$HOME/.config/nvim
ln -sf $dir/init.vim $nvim_configs/init.vim
ln -sf $dir/coc-settings.json $nvim_configs/coc-settings.json

# Uncomment if you like tabout. I think it is not necessary in vim because of normal mode.
# mkdir -p $nvim_configs/after/plugin
# nvim_after_directory=$nvim_configs/after/plugin
# ln -sf $dir/tabout.vim $nvim_after_directory/tabout.vim

# Install NeoVim latest prerelease
curl -LO  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
rm nvim-linux64.deb

# Install Plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +'PlugInstall --sync' +qa
nvim +'UpdateRemotePlugins' +qa
nvim +'CocInstall -sync coc-pyright coc-prettier coc-git coc-json coc-docker coc-yaml coc-highlight coc-sql' +qa
nvim +CocUpdateSync +qa
