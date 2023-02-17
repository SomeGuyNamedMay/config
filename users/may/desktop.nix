{ pkgs, lib, config, ... }: #my-wallpapers, ... }:

{

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  services.gnome-keyring.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
  };

  services.mpris-proxy.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "menu:appmenu";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = false;
    extraConfig = builtins.readFile ./hyprland.conf
                  + "bind=SUPER,SPACE,exec,rofi -show\n";
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = [ "wlr/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "wireplumber" "network" "upower" "clock" ];
        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          on-click = "helvum";
          format-icons = [ "" "" "" ];
        };
        "upower" = {
          icon-size = 20;
          hide-if-empty = false;
        };
        "network" = {
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-disconnected = "";
        };
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
        };
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run";
      sidebar-mode = true;
      show-icons = true;
      icon-theme = "Nordzy";
      display-run = "";
      display-drun = "";
      display-window = "﩯";
  };
};

  programs.qutebrowser = {
    enable = true;
    settings = {
      scrolling.smooth = true;
    };
  };
  programs.chromium.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      mason = {
        isDefault = true;
        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          stylus
          sidebery
          vimium
        ];
      };
    };
  };

  programs.zathura = {
    enable = true;
    extraConfig = ''
      include ${./theme-files/catppuccin-frappe-zathura}
    '';
  };

  programs.kitty = {
    enable = true;
    font.size = 14;
  };

  programs.foot.enable = true;

  services.fnott = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
  };

  xdg.enable = true;
  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "imv %U";
      terminal = false;
      mimeType = [ "image/jpeg" "image/png" ];
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
      "text/plain" = [ "emacs.desktop" ];
      "inode/directory" = [ "thunar.desktop" ];
    };
  };
}
