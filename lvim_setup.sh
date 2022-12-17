#!/bin/bash

dir=$PWD

# To remove all installed neovim and lvim (used to reinstall all again)
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
sudo apt remove --purge -y neovim
sudo apt -y autoclean && sudo apt -y autoremove
rm -rf $HOME/.config/nvim $HOME/.config/coc $HOME/.local/share/nvim $HOME/.cache/nvim
rm -rf $HOME/.config/lvim $HOME/.local/share/lvim $HOME/.cache/lvim

# Install NeoVim latest prerelease
curl -LO  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
rm nvim-linux64.deb
npm install -g neovim

# Install LunarVim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) # install lunarvim
# git clone --branch python-ide https://github.com/LunarVim/starter.lvim.git /tmp/starter.lvim # python lunarvim starter pack
# /usr/bin/python -m pip install -r /tmp/starter.lvim/requirements.txt
# /usr/bin/python -m pip install kitty 
# cp /tmp/starter.lvim/config.lua $HOME/.config/lvim/config.lua
# cd $dir
# rm -rf /tmp/starter.lvim
