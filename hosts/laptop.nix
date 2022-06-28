{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
  ];

  sysPackages = with pkgs; [
    b43FirmwareCutter
  ];

  unstablePackages = with pkgs.unstable; [
  ];

  xfcePackages = with pkgs.xfce; [
  ];

in

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports = [
    INSTALL_ROOT/etc/nixos/secrets/wireless
    INSTALL_ROOT/etc/nixos/secrets/vpn
  ];

  environment = {
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages ++ xfcePackages;
  };

  networking = {
    enableB43Firmware = true;
  };

  services.xserver.libinput = {
    enable = true;
    touchpad.scrollMethod = "twofinger";
  };
}
