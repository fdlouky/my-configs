#!/bin/bash
terminalColorClear='\033[0m'
terminalColorEmphasis='\033[1;32m'
terminalColorError='\033[1;31m'
terminalColorMessage='\033[1;33m'
terminalColorWarning='\033[1;34m'
echoDefault() {
    echo -e "${terminalColorClear}$1${terminalColorClear}"
}
echoMessage() {
    echo -e "${terminalColorMessage}$1${terminalColorClear}"
}
echoWarning() {
    echo -e "${terminalColorWarning}$1${terminalColorClear}"
}
echoError() {
    echo -e "${terminalColorError}$1${terminalColorClear}"
}

# Link my configurations
my_user=$(whoami)
dir=$PWD
mkdir -p $HOME/pipprojects
ln -sf $dir/.bashrc $HOME/.bashrc
ln -sf $dir/.zshrc $HOME/.zshrc
ln -sf $dir/.p10k.zsh $HOME/.p10k.zsh
ln -sf $dir/config $HOME/.config/terminator/config
ln -sf $dir/.aliases $HOME/.aliases

# Show trash in desktop and remove from dock
gsettings set org.gnome.shell.extensions.ding show-trash true
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

# Install nerd fonts
echoMessage "\nInstall nerd fonts?"
select yn in "yes" "no"; do
	case $yn in
		yes ) mkdir -p $HOME/.local/share/fonts
			sudo apt install fonts-powerline
			cd $HOME/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
				https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
			curl -LO https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
			curl -LO https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf
			fc-cache -fv
			# fc-list | grep -i "Droid"
			break;;
		no ) break;;
	esac
done


echoMessage "\nRemap capslock to ctrl?"
select yn in "yes" "no"; do
	case $yn in
		yes ) dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:ctrl_modifier']"
			break;;
		no ) break;;
	esac
done


echoMessage "\nInstall Python and other tools?"
select yn in "yes" "no"; do
	case $yn in
		yes ) sudo apt install -y software-properties-common
			echo | sudo add-apt-repository ppa:deadsnakes/ppa
			sudo apt update -y && sudo apt upgrade -y
			sudo apt install -y python3
			sudo apt install -y screen python-is-python3 python3-pip git gitk curl linux-headers-generic build-essential libssl-dev dkms flake8 pylint make
			git config --global user.name fdlouky
			git config --global user.email fmdlouky@gmail.com
			sudo apt -y install black
			pip3 install --upgrade pip
			pip3 install virtualenv virtualenvwrapper
			pip3 install neovim
      pip3 install pynvim
			source $HOME/.local/bin/virtualenvwrapper.sh
			source $HOME/.bashrc
			cp -f postmkvirtualenv $WORKON_HOME
			break;;
		no ) break;;
	esac
done


echoMessage "\nInstall node, npm, yarn and rust (cargo)?"
select yn in "yes" "no"; do
	case $yn in
		yes)
			# First uninstall nodejs and npm
			sudo apt --purge remove nodejs npm
			sudo apt clean
			sudo apt autoclean
			sudo apt -f install
			sudo apt autoremove
			sudo rm -rf /usr/lib/node_modules/npm/
			sudo rm -rf /usr/local/lib/node_modules/npm
			sudo rm -rf /usr/local/bin/node
			# Now install all
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash	
			source ~/.zshrc
			nvm install node
			npm install -g yarn
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # install cargo (rust)
			npm install -g neovim
			#cargo install tree-sitter-cli
			break;;
		no ) break;;
	esac
done


echoMessage "\nSolve Wifi drivers? (Lenovo issue)"
select yn in "yes" "no"; do
	case $yn in
		yes ) cd && sudo apt install -y git linux-headers-generic build-essential dkms
			git clone https://github.com/Mange/rtl8192eu-linux-driver
			cd rtl8192eu-linux-driver
			sudo dkms add .
			sudo dkms install rtl8192eu/1.0
			echo "blacklist rtl8xxxu" | sudo tee /etc/modprobe.d/rtl8xxxu.conf
			echo -e "8192eu\n\nloop" | sudo tee /etc/modules
			echo "options 8192eu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8192eu.conf
			sudo update-grub; sudo update-initramfs -u
			cd $dir
			break;;
		no ) break;;
	esac
done


echoMessage "\nInstall basic tools?"
select yn in "yes" "no"; do
	case $yn in
		yes ) cd $HOME/Downloads
			wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
			sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
			curl -o code.deb -L http://go.microsoft.com/fwlink/?LinkID=760868
			sudo dpkg -i code.deb
			sudo snap install intellij-idea-community --classic
			sudo snap install pycharm-community --classic
			sudo apt install -y copyq xsel terminator tmux xclip flameshot vlc fzf ripgrep silversearcher-ag exuberant-ctags bat
			sudo snap install dbeaver-ce
			sudo snap install --edge filezilla
			sudo snap install slack --classic
			echo | sudo add-apt-repository ppa:obsproject/obs-studio
			sudo apt update && sudo apt install -y obs-studio
      sudo apt install openjdk-11-jre -y
			break;;
		no ) break;;
	esac
done
cd $dir


echoMessage "\nInstall my favorite terminal?"
select yn in "yes" "no"; do
	case $yn in
		yes ) sudo apt install -y zsh
			chsh -s "$(which zsh)"
			yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
			# git clone https://github.com/jeffreytse/zsh-vi-mode ${zsh_custom:-$home/.oh-my-zsh/custom}/plugins/zsh-vi-mode
			break;;
		no ) break;;
	esac
done


echoMessage "\nSolve Bose Mic issues?"
select yn in "yes" "no"; do
	case $yn in
		yes ) echo | sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
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
			break;;
		no ) break;;
	esac
done


echoMessage "\nConfigure ImprPant as shortcut for flameshot"
select yn in "yes" "no"; do
	case $yn in
		yes ) BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
			KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
			gsettings set org.gnome.shell.keybindings show-screenshot-ui "['']"
			gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEY_PATH/custom0/']"
			$BEGINNING/custom0/ name "Take screenshot with flameshot"
			$BEGINNING/custom0/ command "/usr/bin/flameshot gui"
			$BEGINNING/custom0/ binding "Print"
			# Set <Super>t to open terminal
			gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"
			break;;
		no ) break;;
	esac
done


# Install and setup NeoVim
echoMessage "\nChoose a Vim IDE to install and setup..."
select yn in "Nvim" "Lvim" "none"; do
	case $yn in
		Nvim ) bash $dir/nvim_setup.sh
			break;;
		Lvim ) bash $dir/lvim_setup.sh
			break;;
		none ) break;;
	esac
done


# Install docker and docker-compose
echoMessage "\nInstall docker and docker-compose?"
select yn in "yes" "no"; do
	case $yn in
		yes ) sudo apt install -y apt-transport-https ca-certificates gnupg lsb-release
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
			echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
			sudo apt update
			sudo apt install -y docker-ce
			# Docker Compose
			get_latest_release() {
			  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
				grep '"tag_name":' |                                            # Get tag line
				sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
			}
			LATEST=$(get_latest_release docker/compose)
			sudo curl -L https://github.com/docker/compose/releases/download/$LATEST/docker-compose-`uname -s`-aarch64 -o /usr/local/bin/docker-compose
			sudo chmod +x /usr/local/bin/docker-compose
			break;;
		no ) break;;
	esac
done


# Create SSH to connect Github
echoMessage "\nCreate SSH to connect Github or Bitbucket?"
select yn in "yes" "no"; do
	case $yn in
		yes ) ssh-keygen -t ed25519 -C fmdlouky@gmail.com
			ssh-add $HOME/.ssh/id_ed25519
			echoMessage "\nCopy and paste ssh public key in github or bitbucket account (it was generated for fmdlouky@gmail.com)"
			cat $HOME/.ssh/id_ed25519.pub
			echoWarning "\nWARNING! this pub key was generated for fmdlouky@gmail.com"
			echoWarning "\n Please be sure that you have an ssh repository (instead of an https)!!!"
			break;;
		no ) break;;
	esac
done

