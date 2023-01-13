{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:SomeGuyNamedMy/stylix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, stylix, hyprland, ...}:
    let
      shared-modules = [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          stylix.image = ./resources/wallpapers/log-horizon.jpg;
          home-manager.users.mason = {
            imports = [
                hyprland.homeManagerModules.default
                nur.hmModules.nur
                ./users/may/desktop.nix 
                ./users/may/kakoune.nix
                ./users/may/mpd.nix
                ./users/may/packages.nix
                ./users/may/programming-env.nix
                ./users/may/shell.nix
            ];
            home = {
              stateVersion = "22.11";
              username = "mason";
              homeDirectory = "/home/mason";
            };
          };
        }

        ./systems/configuration.nix
        ./systems/boot.nix
        ./systems/packages.nix
        ./systems/virtualisation.nix
        ./systems/general-hardware.nix
      ];
    in {
      nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-modules ++ [ ./systems/flex/flex-hardware.nix ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-modules ++ [ ./systems/desktop/desktop-hardware.nix ];
      };
  }; 
}
