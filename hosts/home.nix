{ config, lib, pkgs, ... }:

{
    imports = [(import ../modules/desktop/home.nix)] ++
        [(import ../modules/ssh/home.nix)];

    programs.home-manager.enable = true;
}