#!/bin/bash

# Link my configurations
my_user=$(whoami)
dir=$PWD
ln -sf $dir/.bashrc $HOME/.bashrc
ln -sf $dir/.zshrc $HOME/.zshrc
ln -sf $dir/.p10k.zsh $HOME/.p10k.zsh
ln -sf $dir/config $HOME/.config/terminator/config

# Show trash in desktop
gsettings set org.gnome.shell.extensions.ding show-trash true

# Python installations and other tools
sudo apt install -y software-properties-common
echo | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y python3
sudo apt install -y screen python-is-python3 python3-pip git curl linux-headers-generic build-essential dkms flake8 pylint
sudo apt -y install black
pip3 install --upgrade pip
pip3 install virtualenv virtualenvwrapper
source $HOME/.bashrc
echo "pip3 install --upgrade pip && pip3 install pynvim" >> $WORKON_HOME/postmkvirtualenv

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
sudo apt install -y copyq terminator tmux xclip flameshot vlc 
sudo snap install dbeaver-ce
sudo snap install --edge filezilla
sudo snap install slack --classic
echo | sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update && sudo apt install -y obs-studio
cd $dir

# Install my favorite terminal
sudo apt install -y zsh
chsh -s "$(which zsh)"
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Following is to solve Bose Mic issues
echo | sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
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

# Configure ImprPant as shortcut for flameshot
BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['']"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEY_PATH/custom0/']"
$BEGINNING/custom0/ name "Take screenshot with flameshot"
$BEGINNING/custom0/ command "/usr/bin/flameshot gui"
$BEGINNING/custom0/ binding "Print"
# Set <Super>t to open terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal ['<Super>t']

# Install and setup NeoVim
bash $dir/nvim_setup.sh

# Install docker and docker-compose
# Docker
sudo apt install apt-transport-https ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce
# Docker Compose
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
LATEST=$(get_latest_release docker/compose)
sudo curl -L https://github.com/docker/compose/releases/download/$LATEST/docker-compose-`uname -s`-aarch64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
