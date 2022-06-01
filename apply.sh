#!/usr/bin/env bash
pushd ~/dotfiles > /dev/null
sudo nixos-rebuild switch --flake .#
# nix build ".#hmConfig.$USER.activationPackage"
# result/activate
home-manager switch --flake .#royell
popd > /dev/null

cd ~

pushd ~ > /dev/null
if [ -f ~/.walls-installed ]; then
    echo "Wallpapers flagged as installed, skipping extraction."
else
    if [ -f wallpapers.7z.001 ]; then
        7z x -y wallpapers.7z.001
    fi
    touch ~/.walls-installed
fi
chmod 600 .ssh/id_rsa
popd > /dev/null

cd ~/personal-gpg

pushd ~/personal-gpg > /dev/null
# chmod +x install.sh
./install.sh
popd > /dev/null

cd ~/dotfiles