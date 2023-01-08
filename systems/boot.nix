{ pkgs, config, lib, ... }:

{
    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/efi";
        };
        grub = {
            efiSupport = true;
            device = "nodev";
            useOSProber = true;
        };
    };
    boot.plymouth.enable = true;
}
