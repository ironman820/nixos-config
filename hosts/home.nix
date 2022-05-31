{ home-manager, system, pkgs, upkgs, agenix, ... }:
{
    "royell" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        homeDirectory = "/home/royell";
        username = "royell";
        extraModules = [
            ../modules/albert/home.nix
            ../modules/desktop/home.nix
            ../modules/desktop/home-novm.nix
            ../modules/git/home.nix
            ../modules/gpg/home.nix
            ../modules/ssh/home.nix
            ../modules/variety/home.nix
        ];
        extraSpecialArgs = { inherit pkgs upkgs agenix; };
    };
}