{
    description = "My System Config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-21.11";
        nixunstable.url = "nixpkgs/nixos-unstable";
        # nur = {
        #   url = "github:nix-community/NUR";
        #   inputs.nixpkgs.follows = "nixpkgs";
        # };
        agenix.url = "github:ryantm/agenix";
        home-manager = {
            url = "github:/nix-community/home-manager/release-21.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nixunstable, agenix, ... }:
        let
            system = "x86_64-linux";

            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };

            upkgs = import nixunstable {
                inherit system;
                config.allowUnfree = true;
            };

            lib = nixpkgs.lib;

        in {
            nixosConfigurations = (
                import ./hosts {
                    inherit (nixpkgs) lib;
                    inherit system pkgs home-manager upkgs agenix;
                }
            );
            homeManagerConfigurations = (
                import ./hosts/home.nix {
                    inherit (nixpkgs) lib;
                    inherit system pkgs home-manager upkgs agenix;
                }
            );
        };
    }
