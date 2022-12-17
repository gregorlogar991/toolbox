#!/usr/bin/env bash

set -euo pipefail

apt-get update
apt-get upgrade -y
apt-get install -y ca-certificates vim dnsutils strace ngrep htop ncdu git dstat net-tools curl wget iputils-ping tar unzip zip software-properties-common golang-go sudo


ARCH=`uname -m`
if [ "$ARCH" == "x86_64" ]; then
    TF_ARCH="linux_amd64"
    EXA_ARCH="x86_64"
elif [ "$ARCH" == "aarch64" ]; then
    TF_ARCH="darwin_arm64"
    EXA_ARCH="armv7"
else
    echo "Unknown arch"
    exit 1
fi

#TODO: EXA
#EXA_VER=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
#curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-${EXA_ARCH}-v${EXA_VER}.zip"
#unzip -q exa.zip bin/exa -d /usr/local
#TF
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_${TF_ARCH}.zip
#TFNEV
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
#KUBECTL
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

apt-get clean

if [ -e /usr/local/bin/starship.sh ]; then
    sh /usr/local/bin/starship.sh --yes
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

git clone https://github.com/gregorlogar991/dot-files.git /tmp/dot-files
cd /tmp/dot-files
cp .vimrc .bash_functions ~
mkdir -p ~/.config/ && cp starship.toml ~/.config/

#TODO: Fix aliases
#echo "[ -e $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> ~/.bashrc
echo "[ -e $HOME/.bash_functions ] && source $HOME/.bash_functions" >> ~/.bashrc
