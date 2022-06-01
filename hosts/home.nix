{ home-manager, system, ... }:
{
    "royell" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        homeDirectory = "/home/royell";
        username = "royell";
        configuration = import ../users/royell/home.nix;
        # extraSpecialArgs = { inherit pkgs upkgs agenix; };
        stateVersion = "21.11";
    };
}