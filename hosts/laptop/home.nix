{ config, lib, pkgs, ... }:

{
    imports = [(import ../../modules/desktop/home-novm.nix)];
}