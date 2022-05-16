{config, lib, pkgs, imputs, upkgs, ... }:

{
    environment.systemPackages = with pkgs.xfce; [
        xfce4-pulseaudio-plugin
        xfce4-whiskermenu-plugin
    ] ++
    [ 
        pkgs.lightlocker
        pkgs.nixos-icons
    ];
    
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
                        name = "Tela-dark";
                        package = pkgs.tela-icon-theme;
                    };
                };
            };
            desktopManager.xfce.enable = true;
            layout = "us";
        };
    };
}