{
  description = "A comprehensive NixOS+Emacs+HyprLand Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations = {
      continuity = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = [ nur.overlay ]; }
          ({ pkgs, ... }:
          let
            nur-no-pkgs = import nur {
              inherit pkgs;
              nurpkgs = import nixpkgs { system = "x86_64-linux"; };
            };
          in {
            imports = [ ];
          })
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.preston = import ./home.nix;
          }
        ];
      };
    };
  };
}
