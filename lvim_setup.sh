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

# Install LunarVim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) # install lunarvim

# Install python starter pack
# git clone --branch python-ide https://github.com/LunarVim/starter.lvim.git /tmp/starter.lvim # python lunarvim starter pack
# sed -i 's/ueberzug/kitty/g' /tmp/starter.lvim/requirements.txt
# /usr/bin/python -m pip install -r /tmp/starter.lvim/requirements.txt
# cp /tmp/starter.lvim/config.lua $HOME/.config/lvim/config.lua
# cd $dir
# rm -rf /tmp/starter.lvim

echoMessage "\nInstall ChristianChiarulli lvim configuration fork?"
select yn in "yes" "no"; do
	case $yn in
		yes) /usr/bin/python -m pip install jupyterlab pynvim jupyter_client kitty Pillow cairosvg pnglatex plotly kaleido
            git clone git@github.com:fdlouky/lvim.git /tmp/lvim
            cp -a /tmp/lvim/. $HOME/.config/lvim
            rm -rf /tmp/lvim
            # install rust analyzer
            mkdir -p $HOME/.local/bin
            curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $HOME/.local/bin/rust-analyzer
            chmod +x $HOME/.local/bin/rust-analyzer
            # install go
            sudo snap install go --classic
            sudo snap install golangci-lint gopls
            break;;
        no ) break;;
	esac
done
