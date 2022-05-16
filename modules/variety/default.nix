{config, upkgs, ...}:
{
    environment.systemPackages = [
        upkgs.variety
    ];
}