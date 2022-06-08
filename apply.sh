#!/usr/bin/env bash

cd /etc/nixos

sudo git pull

sudo cp hosts/$(cat .host)/configuration.nix ./
sudo cp hosts/$(cat .host)/hardware-configuration.nix ./

sudo sed -i 's/INSTALL_ROOT//' configuration.nix

sudo nixos-rebuild switch --show-trace