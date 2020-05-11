#!/usr/bin/env bash
set -e
set -u
set -o pipefail

# Get ubuntu version
LSB_RELEASE="$(lsb_release -rs | awk -F'.' '{print $1}')"

#Software version
PACKER_VERSION="1.5.6"
DOCKER_COMPOSE_VERSION="1.25.5"

help() {
  echo "Available keys:"
  echo "Use \"-e\" to install VS Code editor"
  echo "Use \"-d\" to choose whether to install Docker"
  echo "Use \"-t\" to install Tilix"
  echo "Use \"-u\" to install DevOps tools (Terraform, Packer)"
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
    && sudo apt-get install docker-ce docker-ce-cli containerd.io

  color_print "Installing docker-compose ..."
    sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

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

vscode_install() {
  if code --version; then
    echo -e "\e[47m\e[36mVS Code is already installed. Skipping installation...\e[0m"
  else 
    color_print "Installing VS Code..."
    wget -O /tmp/vscode.deb https://go.microsoft.com/fwlink/\?LinkID\=760868
    sudo dpkg -i /tmp/vscode.deb
    sudo rm /tmp/vscode.deb
  fi
}

chrome_install() {
  if dpkg -l |grep "chrome"; then 
    echo -e "\e[47m\e[36mChrome is already installed. Skipping installation...\e[0m"
  else 
    color_print "Installing chrome ..."
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update && sudo apt install -y google-chrome-stable
  fi
}

tilix_install() {
  color_print "Installing Tilix Terminal..."
    if [[ "$LSB_RELEASE" = "16" ]]; then
      sudo add-apt-repository ppa:webupd8team/terminix
      sudo apt update && sudo apt install tilix
    elif [[ "$LSB_RELEASE" = "18"|| "$LSB_RELEASE" = "19" ]]; then
      sudo apt install tilix
    else 
      echo -e "\e[47m\e[36mLooks like there is no repo for your Ubuntu distribution... Skipping installation...\e[0m"
    fi
}

configure_zsh () {
  if ls /usr/bin |grep zsh; then 
    echo -e "\e[47m\e[36mZSH is already installed. Skipping installation...\e[0m"
  else
    color_print "Installing zsh ..."
      sudo apt install -y zsh

    color_print "Installing oh-my-zsh ..."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

system_utils_install() {
  color_print "Installing usefull stuff..."
    sudo apt install -y git htop mc
}

devops_utils() {
  #install tfenv
  if git --version; then
    [ -d "~/.tfenv" ] && color_print "Installing tfenv..." && \
      git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
      sudo ln -sf ~/.tfenv/bin/* /usr/local/bin
  else
    echo -e "\e[41m\e[30mGit not installed! Can't install tfenv!\e[0m"
    exit 1
  fi
  
  #install Packer 
  color_print "Installing Packer..."
  wget -O packer.zip https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_"$PACKER_VERSION"_linux_amd64.zip
  unzip packer.zip && sudo mv ./packer /usr/local/bin && rm packer.zip

  color_print "Installing AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm awscliv2.zip
}

## Update system
sudo apt update && sudo apt upgrade -y

common_dependencies

system_utils_install

chrome_install

while getopts ":edthus:" opt
do
  case $opt in
    e) vscode_install
    ;;
    d) docker_install
    ;;
    s)  if [[ $OPTARG = "zsh" ]]; then configure_zsh
        elif [[ $OPTARG = "bash" ]]; then echo "No changes in shell, default is: $SHELL"
        fi 
    ;;
    t) tilix_install
    ;;
    u) devops_utils
    ;;
    h) help
    ;;
    *)  echo -e "\e[41m\e[30mIncorrect option!\e[0m"
        help
        exit 1
    ;;
  esac
done