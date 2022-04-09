{ config, lib, pkgs, user, ... }:

{
    imports = [(import ../../modules/desktop/home-novm.nix)];
}