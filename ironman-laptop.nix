{ config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
    podman-compose
  ];

  networking.hostName = "ironman-laptop";

  virtualisation.podman.enable = true;

}
