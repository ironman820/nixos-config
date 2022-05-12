{ config, pkgs, ... }:

{
    home.file = {
        ".config/xfce4/panel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/xfce4/panel";
        ".config/xfce4/xfconf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/xfce4/xfconf";
    };
    gtk = {
        enable = true;
        theme = {
            name = "Arc-Dark";
            package = pkgs.arc-theme;
        };
        iconTheme = {
            name = "Tela-dark";
            package = pkgs.tela-icon-theme;
        };
    };
}
