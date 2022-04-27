{ lib, inputs, system, home-manager, user, ... }:
{
    ironman-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
            ./laptop
            ./configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit user; };
                    users.${user} = {
                        imports = [(import ./home.nix)];
                    };
                };
            }
        ];
    };
    e105-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
            ./work-laptop
            ./configuration.nix
        ];
    };
    vm = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
            # { nixpkgs.overlays = [ inputs.nur.overlay ]; }
            ./vm
            ./configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit user; };
                    users.${user} = {
                        imports = [(import ./home.nix)] ++ [(import laptop/home.nix)];
                    };
                };
            }
        ];
    };
}
