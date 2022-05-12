{ config, lib, pkgs, ... }:

{
    home = {
        file.wallpapers.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wall";
    };
}