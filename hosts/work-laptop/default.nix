{ config, pkgs, user, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot";
            };
            grub = {
                enable = true;
                version = 2;
                devices = [ "nodev" ];
                efiSupport = true;
            };
            timeout = 5;
        };
    };

    environment.systemPackages = with pkgs; [
        # audiorelay
        b43FirmwareCutter
        blueberry
        calibre
        # cups-pdf
        cura
        docker-compose
        nmap
        poetry
        sqlitebrowser
        tvnamer
        ventoy-bin
        virt-viewer
    ];

    hardware.bluetooth.enable = true;

    networking = {
        hostName = "e105-laptop";
        ddrescue
        ddrescueview
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
            enabled = true;
        };
        xserver.synaptics = {
            enable = true;
            twoFingerScroll = true;
        };
    };
}
