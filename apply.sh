#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .#
# nix build ".#hmConfig.$USER.activationPackage"
# result/activate
popd
