{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        git-crypt
        git-filter-repo
    ];
    programs.git.enable = true;
}