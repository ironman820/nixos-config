{ config, pkgs, user, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
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
        poetry
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

    programs.git.config.safe.directory = [
        "/home/royell/.dotfiles"
    ];

    services = {
        auto-cpufreq.enable = true;
        blueman.enable = true;
        printing = {
            drivers = with pkgs; [
                hplipWithPlugin
            ];
            enable = true;
        };
        xserver.libinput = {
            enable = true;
            touchpad.scrollMethod = "twofinger";
        };
    };

    users.users.royell = {
        isNormalUser = true;
        initialPassword = "Password!";
        extraGroups = [
            "royell"
            "networkmanager"
            "pipewire"
            "wheel"
            "autologin"
        ];
        shell = pkgs.zsh;
    };
}
