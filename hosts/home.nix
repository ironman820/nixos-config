{ home-manager, system, upkgs, ... }:
{
    "royell" = home-manager.lib.homeManagerConfiguration {
        inherit system;
        homeDirectory = "/home/royell";
        username = "royell";
        configuration = import ../users/royell/home.nix;
        extraSpecialArgs = { inherit upkgs; };
        stateVersion = "21.11";
    };
}