#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .#
home-manager switch --flake '.#$(USER)'
popd
