#!/usr/bin/env bash

cd /etc/nixos

sudo git restore .
sudo git pull

sudo cp hosts/$(cat .host)/configuration.nix ./
sudo cp hosts/$(cat .host)/hardware-configuration.nix ./

sudo sed -i 's/INSTALL_ROOT//' configuration.nix
sudo sed -i 's/INSTALL_ROOT//' hardware-configuration.nix
sudo sed -i 's/INSTALL_ROOT//' users/ironman/default.nix
sudo sed -i 's/INSTALL_ROOT//' users/niceastman/default.nix
sudo sed -i 's/INSTALL_ROOT//' users/royell/default.nix
sudo sed -i 's/HOST_NAME/'"$(cat .host)"'/' hardware-configuration.nix

sudo nixos-rebuild switch --show-trace