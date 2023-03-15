{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:SomeGuyNamedMy/stylix/hyprland-support";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };
  outputs = { self, nixpkgs, home-manager, nur, stylix, hyprland, emacs-overlay, ...}:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      shared-modules = [
        stylix.nixosModules.stylix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          stylix.image = ./resources/wallpapers/log-horizon.jpg;
          stylix.polarity = "dark";
          stylix.fonts = {
            serif = {
              package = pkgs.nerdfonts;
              name = "FiraCode Nerd Font";
            };
            sansSerif = {
              package = pkgs.nerdfonts;
              name = "FiraCode Nerd Font";
            };
            monospace = {
              package = pkgs.nerdfonts;
              name = "FiraCode Nerd Font Mono";
            };
            
          };
          nixpkgs.overlays = [
              (import emacs-overlay)
          ];
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
            nixpkgs.overlays = [
                (import emacs-overlay)
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
        extraArgs = {inherit stylix; };
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-modules ++ [ ./systems/desktop/desktop-hardware.nix ];
        extraArgs = {inherit stylix; };
      };
  }; 
}
