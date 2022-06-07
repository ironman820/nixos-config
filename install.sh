#!/usr/bin/env bash

sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
sudo nix-channel --update

sudo git clone -b system --depth 1 https://github.com/ironman820/nixos-config.git /etc/nixos/

sudo ln -s /etc/nixos/hosts/work-laptop/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /etc/nixos/hosts/work-laptop/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

cd /etc/nixos

echo "Please unlock git crypt before continuing."

# sudo git crypt unlock

sudo nixos-install