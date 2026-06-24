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
    
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    mkHost = { hostName, desktop }: lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs hostName desktop;
      };

      modules = [
        ./hosts/${hostName}/configuration.nix
        ./hosts/${hostName}/desktops/${desktop}.nix
        home-manager.nixosModules.default

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs hostName desktop;
            };
            users.mngt = import ./home/${hostName}/home.nix;
          };
        }
      ] ++ lib.optionals (desktop == "niri") [
          niri.nixosModules.niri
      ];
    };
  in {
    nixosConfigurations = {
      thinkpad-kde = mkHost {
        hostName = "thinkpad";
        desktop = "kde";
      };

      thinkpad-niri = mkHost {
        hostName = "thinkpad";
        desktop = "niri";
      };
    };
  };
}
