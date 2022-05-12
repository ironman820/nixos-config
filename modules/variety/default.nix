{config, pkgs, ...}:
{
    environment.systemPackages = [
        pkgs.variety
    ];
}