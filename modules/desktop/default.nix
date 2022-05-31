{config, lib, pkgs, imputs, upkgs, ... }:
let
    xfcePackages = with pkgs.xfce; [
        xfce4-pulseaudio-plugin
        xfce4-whiskermenu-plugin
    ];
    sysPackages = with pkgs; [
        lightlocker
        nixos-icons
    ];
in
{
    environment.systemPackages = xfcePackages ++ sysPackages;
    
    programs.zsh.shellAliases = {
        vim = "code --wait";
    };

    services = {
        xserver = {
            enable = true;

            # Setup LightDM Greeter
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
            # Enable the XFCE Desktop Environment.
            desktopManager.xfce.enable = true;
            layout = "us";
        };
    };
}