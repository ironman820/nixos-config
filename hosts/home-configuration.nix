{ config, home-manager, ... }:
{
    imports = [
        ../modules/albert/home.nix
        ../modules/desktop/home.nix
        ../modules/desktop/home-novm.nix
        ../modules/git/home.nix
        ../modules/gpg/home.nix
        ../modules/ssh/home.nix
        ../modules/variety/home.nix
    ];
    programs.home-manager.enable = true;
    # specialArgs = { inherit pkgs upkgs agenix; };
}