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

    dotfiles.url = "github:mngste/dotfiles";
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.lorient = nixpkgs.lib.nixosSystem {
      inherit system;

      # for modules (include home.nix) to see `inputs`
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/thinkpad/configuration.nix
        home-manager.nixosModules.default

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.mngt = import ./home/thinkpad/home.nix;
          };
        }
      ];
    };
  };
}
