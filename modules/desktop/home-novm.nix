{ config, lib, pkgs, ... }:

{
    home = {
        file."wallpapers.7z.001".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.001";
        file."wallpapers.7z.002".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.002";
        file."wallpapers.7z.003".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.003";
        file."wallpapers.7z.004".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.004";
        file."wallpapers.7z.005".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.005";
        file."wallpapers.7z.006".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/themes/wallpapers.7z.006";
    };
}