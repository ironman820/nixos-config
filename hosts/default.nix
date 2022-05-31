{ lib, system, home-manager, upkgs, agenix, ... }:
{
    e105-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit agenix home-manager upkgs; };
        modules = [
            agenix.nixosModule
            ./work-laptop
            ./configuration.nix
            #     home-manager = {
            #         useGlobalPkgs = true;
            #         useUserPackages = true;
            #     };
        ];
    };
}
