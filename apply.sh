#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .#
# nix build ".#hmConfig.$USER.activationPackage"
# result/activate
popd

pushd ~
if [ -f "wallpapers.7z" ]; then
    7z x wallpapers.7z
    rm wallpapers.7z
fi
popd