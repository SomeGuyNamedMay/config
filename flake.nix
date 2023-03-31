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
    idris.url = "github:/idris-lang/Idris2";
  };
  outputs = { self, nixpkgs, home-manager, nur, stylix, hyprland, emacs-overlay, idris, ...}:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      shared-modules = [
        stylix.nixosModules.stylix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          stylix.image = ./resources/wallpapers/ffxiv-wallpaper.jpg;
          stylix.polarity = "dark";
          stylix.fonts = {
            serif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Serif";
            };
            sansSerif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Sans";
            };
            monospace = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Sans Mono";
            };
            sizes = {
                desktop = 12;
                applications = 15;
                terminal = 15;
                popups = 12;
            };
          };
          stylix.targets = {
              grub.useImage = true;
          };
          nixpkgs.overlays = [
              (import emacs-overlay)
            (super: self: {
                emacsPackages.idris2-mode = idris.packages.x86_64-linux.idris2-mode;
            })
          ];
          home-manager.users.mason = {
            imports = [
                hyprland.homeManagerModules.default
                nur.hmModules.nur
                ./users/may/desktop.nix 
                ./users/may/kakoune.nix
                ./users/may/media.nix
                ./users/may/web.nix
                ./users/may/packages.nix
                ./users/may/programming-env.nix
                ./users/may/shell.nix
            ];
            stylix.targets.waybar = {
                enableLeftBackColors = true;
                enableRightBackColors = true;
            };
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
