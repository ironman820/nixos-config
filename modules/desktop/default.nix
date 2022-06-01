{config, lib, pkgs, imputs, upkgs, ... }:
let
    xfcePackages = with pkgs.xfce; [
        xfce4-pulseaudio-plugin
        xfce4-whiskermenu-plugin
    ];
    sysPackages = with pkgs; [
        adoptopenjdk-icedtea-web
        firefox
        flameshot
        font-manager
        galculator
        gimp
        gnome.file-roller
        libsForQt5.okular
        libsForQt5.qtstyleplugin-kvantum
        libreoffice
        lightlocker
        nixos-icons
        pavucontrol
        pulseaudio # used for pactl, not enabled
        putty
        synology-drive
    ];

    # unstablePackages = with upkgs; [
    #     vscode
    # ];
in
{
    environment.systemPackages = xfcePackages ++ sysPackages ++
        [ upkgs.vscode ];
    
    programs.zsh.shellAliases = {
        vim = "code --wait";
    };

    security.rtkit.enable = true; # Needed for pipewire

    services = {
        gnome.gnome-keyring.enable = true;
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
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