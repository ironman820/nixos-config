{ config, pkgs, ... }:

{
    home.file = {
        ".config/xfce4/panel" = {
            source = ../../config/xfce4/panel;
            recursive = true;
        };
        ".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".source = ../../config/xfce4/xfce4-keyboard-shortcuts.xml;
        ".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml".source = ../../config/xfce4/xfce4-panel.xml;
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
