{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
  ];

  sysPackages = with pkgs; [
    makemkv
  ];

  unstablePackages = with pkgs.unstable; [
  ];

in

{
  environment.systemPackages = qt5Packages ++ sysPackages ++ unstablePackages;
}
