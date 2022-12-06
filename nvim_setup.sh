#!/bin/bash
dir=$PWD
mkdir $HOME/.config/nvim
nvim_configs=$HOME/.config/nvim
ln -sf $dir/init.vim $nvim_configs/init.vim
ln -sf $dir/coc-settings.json $nvim_configs/coc-settings.json

# Install nerd fonts
mkdir -p $HOME/.local/share/fonts
sudo apt install fonts-powerline
cd $HOME/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# Install NeoVIm stuffs
sudo apt install -y exuberant-ctags nodejs
# Uncomment following lines if npm is not included in nodejs installation
# sudo apt install -fy npm
# sudo npm install -g npm@latest
# sudo npm cache clean -f
# sudo npm install -g n
# sudo n stable
sudo npm install -g npm
sudo npm install -g yarn
echo | sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update
sudo apt install -y neovim bat
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +'PlugInstall --sync' +qa
nvim +'UpdateRemotePlugins' +qa
nvim +'CocInstall -sync coc-pyright coc-prettier coc-git coc-json coc-docker coc-yaml coc-highlight coc-sql' +qa
nvim +CocUpdateSync +qa

# To remove all installed neovim (used to reinstall all again)
# sudo apt remove --purge -y neovim
# sudo apt -y autoclean && sudo apt -y autoremove
# rm -rf $HOME/.config/nvim $HOME/.config/coc $HOME/.local/share/nvim

# To remove all related nodejs and npm
# sudo apt --purge remove nodejs npm
# sudo apt clean
# sudo apt autoclean
# sudo apt -f install
# sudo apt autoremove
# sudo rm -rf /usr/lib/node_modules/npm/
