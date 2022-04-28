{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            systemd-boot.enable = true;
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
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
        phodav
    ];

    networking = {
        hostName = "vm";
        interfaces.ens18.useDHCP = true;
    };

    services = {
        gvfs.enable = true;
        qemuGuest.enable = true;
        spice-vdagentd.enable = true;
    };
}
