{config, lib, pkgs, imputs, ... }:

{
    environment.systemPackages = [ pkgs.xfce.xfce4_whiskermenu_plugin ];
    services = {
        xserver = {
            enable = true;

            # Enable the XFCE Desktop Environment.
            displayManager.lightdm = {
                enable = true;
                greeters.gtk = {
                    theme = {
                        name = "Arc-Dark";
                        package = pkgs.arc-theme;
                    };
                    iconTheme = {
                        name = "Tela-red-dark";
                        package = pkgs.tela-icon-theme;
                    };
                };
            };
            desktopManager.xfce.enable = true;
            layout = "us";
        };
    };
}