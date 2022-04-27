{ config, lib, pkgs, user, ... }:

{
    imports = [(import ../modules/desktop/home.nix)];

    programs.home-manager.enable = true;
}