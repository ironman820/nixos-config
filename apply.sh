#!/usr/bin/env sh
pushd ~/dotfiles > /dev/null
sudo nixos-rebuild switch --flake .# --show-trace
# nix build ".#hmConfig.$USER.activationPackage"
# result/activate
popd > /dev/null

pushd ~ > /dev/null
if [ -f "~/.walls-installed" ]; then
    echo "Wallpapers flagged as installed, skipping extraction."
else
    if [ -f "wallpapers.7z.001" ]; then
        7z x -y wallpapers.7z.001
    fi
    touch ~/.walls-installed
fi
rm ~/wallpapers.7z.00* 2>&1 > /dev/null
chmod 600 .ssh/id_rsa
popd > /dev/null

pushd ~/personal-gpg > /dev/null
# chmod +x install.sh
./install.sh
popd > /dev/null