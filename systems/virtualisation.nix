{pkgs, config, lib, ...}:

{
  virtualisation.libvirtd.enable = true;
  virtualisation = {
      waydroid.enable = true;
      lxd.enable = true;
  };
}
