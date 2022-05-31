#!/usr/bin/env sh
pushd ~/dotfiles
sudo nixos-rebuild switch --flake .# --show-trace
# nix build ".#hmConfig.$USER.activationPackage"
# result/activate
popd

pushd ~
if [ -f "wallpapers.7z.001" ]; then
    7z x -y wallpapers.7z.001
    rm wallpapers.7z.00*
fi
chmod 600 .ssh/id_rsa
popd

pushd ~/personal-gpg
./personal-gpg/install.sh
popd