{ config, lib, pkgs, modulesPath, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ironman = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "podman" ];
    packages = with pkgs; [
      tree
    ];
  };
}
