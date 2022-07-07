{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
  ];

  sysPackages = with pkgs; [
  ];

  unstablePackages = with pkgs.unstable; [
  ];

in

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports = [
    INSTALL_ROOT/etc/nixos/hosts/core.nix
    INSTALL_ROOT/etc/nixos/hosts/laptop.nix
    INSTALL_ROOT/etc/nixos/hosts/personal.nix
    INSTALL_ROOT/etc/nixos/users/ironman
  ];

  environment = {
    etc = {
      "ssh/ssh_host_ed25519_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_ed25519_key";
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_ed25519_key.pub";
      };
      "ssh/ssh_host_rsa_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_rsa_key";
      };
      "ssh/ssh_host_rsa_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_rsa_key.pub";
      };
      "ssh/ssh_host_dsa_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_dsa_key";
      };
      "ssh/ssh_host_dsa_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_dsa_key.pub";
      };
      "ssh/ssh_host_ecdsa_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_ecdsa_key";
      };
      "ssh/ssh_host_ecdsa_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/ironman-laptop/ssh_host_ecdsa_key.pub";
      };
    };
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  networking = {
    hostName = "ironman-laptop";
  };

  virtualisation.docker.enable = true;
}
