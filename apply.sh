#!/usr/bin/env bash

cd /etc/nixos

hostname=$(cat .host)

sudo git restore .
sudo git branch | grep -iq user ;
if [ $? != 0 ]; then
    sudo git fetch --unshallow
    sudo git remote set-branches origin '*'
    sudo git fetch -v
fi
sudo git checkout user
sudo git pull

sudo cp hosts/$hostname/configuration.nix ./
sudo cp hosts/$hostname/hardware-configuration.nix ./

sudo sed -i 's/INSTALL_ROOT//' configuration.nix
sudo sed -i 's/INSTALL_ROOT//' hardware-configuration.nix
sudo sed -i 's/INSTALL_ROOT//' hosts/core.nix
sudo sed -i 's/INSTALL_ROOT//' hosts/laptop.nix
sudo sed -i 's/INSTALL_ROOT//' users/ironman/default.nix
sudo sed -i 's/INSTALL_ROOT//' users/niceastman/default.nix
sudo sed -i 's/INSTALL_ROOT//' users/royell/default.nix
sudo sed -i 's/HOST_NAME/'"$hostname"'/' hardware-configuration.nix

sudo nixos-rebuild switch

cd ~
if [ -f ~/.walls-installed ]; then
    echo "Wallpapers flagged as installed, skipping extraction."
else
    if [ -f wallpapers.7z.001 ]; then
        7z x -y wallpapers.7z.001
    fi
    touch ~/.walls-installed
fi
chmod 600 .ssh/id_rsa

cd ~/personal-gpg
./install.sh
