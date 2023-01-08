{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, ...}:
    let
      shared-modules = [
        ./systems/configuration.nix
        ./systems/boot.nix
        ./systems/packages.nix
        ./systems/virtualisation.nix
        ./systems/general-hardware.nix
      ];
    in {
      nixosConfigurations.flex = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-modules ++ [ ./systems/flex-hardware.nix ];
      };
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared-modules ++ [ ./systems/desktop-hardware.nix ];
      };
    }; 
}
