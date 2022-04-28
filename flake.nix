{
    description = "My System Config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-21.11";
        # nur = {
        #   url = "github:nix-community/NUR";
        #   inputs.nixpkgs.follows = "nixpkgs";
        # };
        home-manager = {
            url = "github:/nix-community/home-manager/release-21.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { self, nixpkgs, home-manager, ... }:
        let
            system = "x86_64-linux";
            user = "ironman";

            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };

            lib = nixpkgs.lib;

        in {
            hmConfig = {
                ironman = home-manager.lib.homeManagerConfiguration {
                    inherit system pkgs;
                    username = "ironman";
                    homeDirectory = "/home/ironman";
                    configuration = [(import ./hosts/home.nix)];
                    # stateVersion = "21.11";
                };
                royell = home-manager.lib.homeManagerConfiguration {
                    inherit system pkgs;
                    username = "royell";
                    homeDirectory = "/home/royell";
                    configuration = {
                        imports = [
                            ./hosts/home.nix
                            ./hosts/work-laptop/home.nix
                        ];
                    };
                    # stateVersion = "21.11";
                };
            };
            nixosConfigurations = (
                import ./hosts {
                    inherit (nixpkgs) lib;
                    inherit inputs user system pkgs home-manager;
                }
            );
        };
    }
