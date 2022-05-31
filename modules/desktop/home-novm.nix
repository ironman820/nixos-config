{ config, lib, pkgs, ... }:

{
    home.file = {
        "wallpapers.7z.001".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.001";
        "wallpapers.7z.002".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.002";
        "wallpapers.7z.003".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.003";
        "wallpapers.7z.004".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.004";
        "wallpapers.7z.005".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.005";
        "wallpapers.7z.006".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/themes/wallpapers.7z.006";
    };
}