#!/bin/bash

# Link my configurations
my_user=$(whoami)
dir=$PWD
ln -s $dir/.bashrc $HOME/.bashrc
ln -s $dir/.zshrc $HOME/.zshrc
ln -s $dir/.p10k.zsh $HOME/.p10k.zsh
ln -s $dir/config $HOME/.config/terminator/config

# Show trash in desktop
gsettings set org.gnome.shell.extensions.ding show-trash true

# Python installations and other tools
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y screen python-is-python3 python3-pip git curl linux-headers-generic build-essential dkms flake8 pylint
pip3 install --upgrade pip
pip3 install virtualenv virtualenvwrapper
source $HOME/.bashrc

# Uncomment following to solve WiFi driver issue in Lenovo
# git clone https://github.com/Mange/rtl8192eu-linux-driver $HOME
# sudo dkms add $HOME/rtl8192eu-linux-driver
# sudo dkms install $HOME/rtl8192eu-linux-driver/rtl8192eu/1.0
# echo "blacklist rtl8xxxu" | sudo tee /etc/modprobe.d/rtl8xxxu.conf
# echo -e "8192eu\n\nloop" | sudo tee /etc/modules
# echo "options 8192eu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8192eu.conf
# sudo update-grub; sudo update-initramfs -u

# Install basic tools
cd $HOME/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
curl -o code.deb -L http://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code.deb
sudo snap install intellij-idea-community --classic
sudo snap install pycharm-community --classic
sudo apt install -y copyq
sudo snap install flameshot
sudo snap install vlc
sudo snap install --edge filezilla
sudo snap install dbeaver-ce
sudo snap install docker
sudo snap install slack --classic
sudo apt install -y terminator
sudo apt install -y tmux
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update && sudo apt install -y obs-studio
cd $dir

# Install my favorite terminal
sudo apt install -y zsh
chsh -s $(which zsh)
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Following is to solve Bose Mic issues
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y pipewire
sudo apt install -y libspa-0.2-bluetooth
sudo apt install -y pipewire-audio-client-libraries
systemctl --user daemon-reload
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user mask pulseaudio
systemctl --user --now enable pipewire-media-session.service
systemctl --user restart pipewire
# Uncomment following to show audio info
# pactl info

# Install and setup NeoVim
bash $dir/nvim_setup.sh