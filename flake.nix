{
  description = "config NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    mkHost = hostName: lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs hostName;
      };

      modules = [
        ./hosts/${hostName}/configuration.nix
        ./modules/noctalia.nix
        home-manager.nixosModules.default

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs hostName;
            };
            users.mngt = import ./home/${hostName}/home.nix;
          };
        }
      ];
    };
  in {
    nixosConfigurations = {
      thinkpad = mkHost "thinkpad";

      # exemple pour une deuxième machine
      # desktop = mkHost "desktop";
    };
  };
}
