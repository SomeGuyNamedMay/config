{pkgs, config, lib, ...}:

{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    trashy
    tldr
    pamixer
    playerctl
    home-manager
  ];
}
