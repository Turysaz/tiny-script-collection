#!/bin/bash

# =============================
#
#   UPDATES GITEA INSTALLATION
#
#   Run this script by ./upd...
#   Do not prefix with sudo.
#   This script will use sudo itself and ask for the password.
#
# =============================

if [[ $1 == "" ]];
then
    echo "Run 'bash <this script> <version>'"
    echo "For example:"
    echo "   ./<script>.sh 1.15.7"
    exit
fi

version=$1

binary=gitea-${version}
signature=gitea-${version}.asc

function echo-red
{
    echo -e "\e[31m$1\e[0m"
}

function echo-green
{
    echo -e "\e[32m$1\e[0m"
}


if [[ ! -f $binary ]]; then
    echo "downloading binary"
    wget -O $binary https://dl.gitea.io/gitea/${version}/gitea-${version}-linux-amd64
else
    echo "binary already downloaded. skipping."
fi

if [[ ! -f $signature ]]; then
    echo "downloading signature"
    wget -O $signature https://dl.gitea.io/gitea/${version}/gitea-${version}-linux-amd64.asc
else
    echo "signature file already existing. skipping."
fi

echo "Updating signature keys"
gpg --keyserver keys.openpgp.org --recv 7C9E68152594688862D62AF62D9AE806EC1592E2

echo "Verifying signature"
gpg --verify "$signature" "$binary"

if [[ $? != 0 ]]; then
    echo-red "BAD SIGNATURE. ABORT!"
    exit 1
fi

echo "signature good"

echo "stopping gitea service"
sudo systemctl stop gitea

echo "cloning binary to /usr/local/bin"
sudo cp $binary /usr/local/bin/
cd /usr/local/bin
sudo chmod +x $binary

echo "set capability for privileged port"
for f in $(find /usr/local/bin -name 'gitea-*'); do
	sudo setcap 'cap_net_bind_service=-ep' $f
done
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/$binary

sudo rm gitea

echo "creating link"
sudo ln -s $binary gitea

echo "starting gitea service"
sudo systemctl start gitea

sudo -k # forget sudo login, so this does not accidentally leave a root shell

echo-green "done."

echo-red "You may want to run regular updates as well? :-)"

