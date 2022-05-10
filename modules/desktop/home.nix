{ config, pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            name = "Arc-Dark";
            package = pkgs.arc-theme;
        };
        iconTheme = {
            name = "Tela-red-dark";
            package = pkgs.tela-icon-theme;
        };
    };

    home.file.".config/xfce4" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/xfce4";
        recursive = true;
    };
    
}
