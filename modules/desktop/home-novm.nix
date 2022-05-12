{ config, lib, pkgs, ... }:

{
    home = {
        file."wallpapers.7z".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z";
    };
}