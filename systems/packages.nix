{pkgs, config, lib, ...}:

{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    trashy
    tldr
    home-manager
  ];
}
