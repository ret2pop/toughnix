{
  description = "A comprehensive NixOS+Emacs+HyprLand Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers.url = "github:ret2pop/wallpapers";
    sops-nix.url = "github:Mic92/sops-nix";
    scripts.url = "github:ret2pop/scripts";
  };

  outputs = { self, nixpkgs, home-manager, nur, disko, wallpapers, sops-nix, scripts, ... }@attrs: {
    nixosConfigurations = {
      live = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          { nixpkgs.overlays = [ nur.overlay ]; }
          ({ pkgs, ... }:
            let
              nur-no-pkgs = import nur {
                inherit pkgs;
                nurpkgs = import nixpkgs { system = "x86_64-linux"; };
              };
            in
            {
              imports = [ ];
            })
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = attrs;
            home-manager.useUserPackages = true;
            home-manager.users.preston = import ./home.nix;
          }
        ];
      };
      continuity = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          { nixpkgs.overlays = [ nur.overlay ]; }
          ({ pkgs, ... }:
            let
              nur-no-pkgs = import nur {
                inherit pkgs;
                nurpkgs = import nixpkgs { system = "x86_64-linux"; };
              };
            in
            {
              imports = [ ];
            })
          ./configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = attrs;
            home-manager.useUserPackages = true;
            home-manager.users.preston = import ./home.nix;
          }
        ];
      };
    };
  };
}
