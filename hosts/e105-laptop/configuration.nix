{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
  ];

  sysPackages = with pkgs; [
  ];

  unstablePackages = with pkgs.unstable; [
  ];

  xfcePackages = with pkgs.xfce; [
  ];

in

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports = [
    INSTALL_ROOT/etc/nixos/hosts/core.nix
    INSTALL_ROOT/etc/nixos/hosts/laptop.nix
    INSTALL_ROOT/etc/nixos/users/niceastman
    INSTALL_ROOT/etc/nixos/users/royell
  ];

  environment = {
    etc = {
      "ssh/ssh_host_ed25519_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_ed25519_key";
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_ed25519_key.pub";
      };
      "ssh/ssh_host_rsa_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_rsa_key";
      };
      "ssh/ssh_host_rsa_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_rsa_key.pub";
      };
    };
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages ++ xfcePackages;
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
    hostName = "e105-laptop";
  };
}
