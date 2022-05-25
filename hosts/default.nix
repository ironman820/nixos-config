{ lib, inputs, system, home-manager, upkgs, agenix, ... }:
{
    e105-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs agenix home-manager upkgs; };
        modules = [
            agenix.nixosModule
            ./work-laptop
            ./configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.royell = {
                        imports = [(import ./home.nix)] ++
                        [(import ../modules/albert/home.nix)] ++
                        [(import ../modules/desktop/home-novm.nix)] ++
                        [(import ../modules/git/home.nix)] ++
                        [(import ../modules/variety/home.nix)] ++
                        [(import ../users/royell/home.nix)];
                    };
                };
            }
        ];
    };
}
