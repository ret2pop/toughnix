{
  description = "A comprehensive NixOS+Emacs+HyprLand Configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    scripts.url = "github:ret2pop/scripts";
    wallpapers.url = "github:ret2pop/wallpapers";
  };

  outputs = { nixpkgs, home-manager, nur, disko, lanzaboote, ... }@attrs: {
    nixosConfigurations = {
      live = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          { nixpkgs.overlays = [ nur.overlays.default ]; }
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
            home-manager = {
              useGlobalPkgs = true;
              extraSpecialArgs = attrs;
              useUserPackages = true;
              users.preston = import ./home.nix;
            };
          }
        ];
      };

      continuity-dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          { nixpkgs.overlays = [ nur.overlays.default ]; }
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
          lanzaboote.nixosModules.lanzaboote
          ./configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              extraSpecialArgs = attrs;
              useUserPackages = true;
              users.preston = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
