{ config, pkgs, upkgs, ...}:
let
    sysPackages = with pkgs; [
        google-chrome
    ];

    unstablePackages = with upkgs; [
        microsoft-edge
    ];
in
{
    environment.systemPackages = sysPackages ++ unstablePackages;
}