# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, stylix, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  programs.nix-ld.enable = true;
  nix.optimise.automatic = true;

  services.transmission.enable = true;

  services.udisks2.enable = true;

  programs.light.enable = true;



  services.upower.enable = true;

  programs.dconf.enable = true;
  programs.gamemode.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
    ];
  };
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet";
      };
      initial_session = {
        command = "Hyprland";
        user = "mason";
      };
    };
  };
  
  services.dbus.enable = true;
  services.octoprint.enable = true;

  services.gvfs.enable = true;

  programs.hyprland.enable = true;

  services.tumbler.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  #fonts = {
  #    fonts = with pkgs;  [
  #        cascadia-code
  #        nerdfonts
  #    ];
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mason = {
    isNormalUser = true;
    description = "Mason Dear";
    extraGroups = [ "networkmanager" "transmission" "wheel" "libvirtd" "video" "audio" "kvm" "dialout" "octoprint" "greetd"];
    shell = pkgs.zsh;
  };

  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
