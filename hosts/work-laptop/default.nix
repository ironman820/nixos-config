{ config, pkgs, upkgs, agenix, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/albert
        ../../modules/desktop
        # ../../modules/glocom
        ../../modules/variety
        ../../modules/yubikey
        ../../secrets/wireless
        ../../secrets/vpn
        ../../users/royell
    ];

    # age.secrets."royell.rsa" = {
    #     file = ../../secrets/home/royell/rsa.age;
    #     group = "users";
    #     owner = "royell";
    #     path = "/home/royell/.ssh/id_rsa";
    #     symlink = false;
    # };

    # age.secrets.work-laptop-host-key = {
    #     file  = ../../secrets/keys/work-laptop/ssh_rsa.age;
    #     path = "/etc/ssh/ssh_host_rsa_key";
    #     mode = "0400";
    # };

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
            configurationLimit = 10;
            enable = true;
        };
        timeout = 2;
    };

    environment = {
        etc = {
            "ssh/ssh_host_ed25519_key" = {
                source = ../../secrets/keys/work-laptop/ssh_host_ed25519_key;
                mode = "0400";
            };
            "ssh/ssh_host_ed25519_key.pub" = {
                source = ../../secrets/keys/work-laptop/ssh_host_ed25519_key.pub;
                mode = "0444";
            };
            "ssh/ssh_host_rsa_key" = {
                source = ../../secrets/keys/work-laptop/ssh_host_rsa_key;
                mode = "0400";
            };
            "ssh/ssh_host_rsa_key.pub" = {
                source = ../../secrets/keys/work-laptop/ssh_host_rsa_key.pub;
                mode = "0444";
            };
        };

        systemPackages = with pkgs; [
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
    };

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
