{ config, pkgs, ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
        theme = pkgs.nixos-grub2-theme;
      };
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 10;
      # };
    };
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [
        pkgs.nixos-bgrt-plymouth
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    distrobox
    podman-compose
  ];

  networking.hostName = "ironman-laptop";

  virtualisation.podman.enable = true;

}
