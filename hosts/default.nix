# { lib, inputs, system, home-manager, agenix, ... }:
{ lib, inputs, system, home-manager, ... }:
{
    e105-laptop = lib.nixosSystem {
        inherit system;
        # specialArgs = { inherit inputs agenix home-manager; };
        specialArgs = { inherit inputs home-manager; };
        modules = [
            ./work-laptop
            ./configuration.nix
            # agenix.nixosModule
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.royell = {
                        imports = [(import ./home.nix)] ++
                        [(import ../users/royell/home.nix)];
                    };
                };
            }
        ];
    };
}
