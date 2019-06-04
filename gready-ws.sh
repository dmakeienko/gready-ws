#!/usr/bin/env bash

# Get ubuntu version
LSB_RELEASE="$(lsb_release -rs | awk -F'.' '{print $1}')"


help() {
  echo "Available keys:"
  echo "Use \"-e [ sublime | vscode ]\" to choose editor"
  echo "Use \"-d\" to choose whether to install Docker"
  echo "Use \"-t [ guake | tilix ] \" to choose which terminal do you prefer"
  echo "Use \"-s [ zsh | bash ] \" to choose which shell do you prefer"
}



# Make output readable
color_print() {
    message="$1"
    printf "\e[44m$message\e[0m\n"
}

docker_install() {
  color_print "Installing Docker CE ..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && sudo apt-key fingerprint 0EBFCD88 \
    && sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    sudo apt-get update \
    && sudo apt-get install docker-ce

  color_print "Installing docker-compose ..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && sudo chmod +x /usr/local/bin/docker-compose

  color_print "Let's add you to the group \"docker\"..."
    sudo usermod -aG docker `whoami`

  color_print "Don't forget re-login..."
}

common_dependencies() {
  color_print "Installing common dependencies ..."
  sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    build-essential \
    software-properties-common
}

sublime_install() {
  color_print "Installing Sublime Text 3 ..."
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update && sudo apt -y install sublime-text
}

vscode_install() {
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update && sudo apt install -y code
}

google-chrome_install() {
  color_print "Installing chrome ..."
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update && sudo apt install -y google-chrome-stable
}

tilix_install() {
  color_print "Installing Tilix Terminal..."
    if [[ "$LSB_RELEASE" = "16" ]]; then
      sudo add-apt-repository ppa:webupd8team/terminix
      sudo apt update && sudo apt install tilix
    elif [[ "$LSB_RELEASE" = "18" ]]; then
      sudo apt install tilix
    else 
      color_print "Looks like you need something else..."
    fi
}

guake_install() {
  sudo apt install -y guake
}

configure_zsh () {
  color_print "Installing zsh ..."
    sudo apt install -y zsh

  color_print "Installing oh-my-zsh ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

system_utils_install() {
  color_print "Installing usefull stuff..."
    sudo apt install -y git htop mc
}

# # Update system
sudo apt update

common_dependencies

system_utils_install

google-chrome_install

while getopts "e:ds:t:h" opt
do
  case $opt in
    e)  if [[ $OPTARG = "sublime" ]]; then sublime_install
        elif [[ $OPTARG = "vscode" ]]; then vscode_install
        fi
    ;;
    d)  docker_install
    ;;
    s)  if [[ $OPTARG = "zsh" ]]; then configure_zsh
        elif [[ $OPTARG = "bash" ]]; then echo "No changes in shell, default is: $SHELL"
        fi 
    ;;
    t)  if [[ $OPTARG = "tilix" ]]; then tilix_install
        elif [[ $OPTARG = "guake" ]]; then guake_install
        fi
    ;;
    h) help
    ;;
    *)  echo -e "\e[41m\e[30mIncorrect option!\e[0m"
        help
        exit 1
    ;;
  esac
done