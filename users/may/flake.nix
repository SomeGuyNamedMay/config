{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nur, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.mason = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {};
        modules = [
          { home.stateVersion = "22.11";
            home.username = "mason";
            home.homeDirectory = "/home/mason";
          }
          nur.hmModules.nur
          { nixpkgs.overlays = []; 
          }
          hyprland.homeManagerModules.default
          ./shell.nix
          ./kakoune.nix
          ./mpd.nix
          ./desktop.nix
          ./packages.nix
          ./programming-env.nix
        ];
      };
    };
}
