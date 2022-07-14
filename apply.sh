#!/usr/bin/env bash

if [[ ! -f ".updated" ]]; then
  echo "Adding and updating Nix Channels"
  sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixos 2>&1 > /dev/null
  sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable 2>&1 > /dev/null
  sudo nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix 2>&1 > /dev/null
  sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
  sudo nix-channel --update 2>&1 > /dev/null
  touch .updated
  echo "Finished adding channels."
fi

rm -f ~/.config/fontconfig/conf.d/10-hm-fonts.conf

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
