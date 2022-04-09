{ config, lib, pkgs, user, ... }:

{
    imports = [(import ../modules/desktop/home.nix)];

    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "21.11";
    };

    programs.home-manager.enable = true;
}