{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.blueberry
    ];

    hardware.bluetooth.enable = true;

    services.blueman.enable = true;
}