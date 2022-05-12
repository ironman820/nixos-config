{config, pkgs, ...}:
{
    environment.systemPackages = [
        pkgs.albert
    ];
}