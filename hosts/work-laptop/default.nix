{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../users/royell
    ];

    # age.secrets."royell.rsa" = {
    #     file = ../../secrets/home/royell/rsa.age;
    #     group = "users";
    #     owner = "royell";
    #     path = "/home/royell/.ssh/id_rsa";
    #     symlink = false;
    # };

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
            configurationLimit = 10;
            enable = true;
        };
        timeout = 2;
    };

    environment.systemPackages = with pkgs; [
        # audiorelay
        b43FirmwareCutter
        blueberry
        # cups-pdf
        ddrescue
        ddrescueview
        nmap
        sqlitebrowser
        ventoy-bin
        virt-viewer
    ];

    hardware.bluetooth.enable = true;

    networking = {
        hostName = "e105-laptop";
        enableB43Firmware = true;
        networkmanager.enableStrongSwan = true;
    };

    services = {
        auto-cpufreq.enable = true;
        blueman.enable = true;
        printing = {
            drivers = with pkgs; [
                hplipWithPlugin
            ];
            enable = true;
        };
        xserver = {
            libinput = {
                enable = true;
                touchpad.scrollMethod = "twofinger";
            };
        };
    };
}
