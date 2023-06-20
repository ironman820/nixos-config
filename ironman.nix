{ config, lib, pkgs, modulesPath, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ironman = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
}
