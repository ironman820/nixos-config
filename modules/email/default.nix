{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        birdtray
        thunderbird
    ];
}