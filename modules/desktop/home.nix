{ pkgs, ... }:

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
}
