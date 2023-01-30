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

  #programs.ironbar = {
  #  enable = true;
  #  systemd = true;
  #  config = {
  #    position = "right";
  #    start = [
  #      {
  #        type = "focused";
  #        show_icon = true;
  #        show_title = false;
  #        icon_size = 32;
  #        icon_theme = "Zafiro";
  #      }
  #      {
  #        type = "workspaces";
  #      }
  #    ];
  #    end = [
  #      {
  #        type = "tray";
  #      }
  #    ];
  #  };
  #  style = "";
  #};

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    style = ./nord-waybar.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "bluetooth" "pulseaudio" "battery" ];
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
      };
    };
    extensions = with config.nur.repos.rycee.firefox-addons; [
      ublock-origin
      sponsorblock
      stylus
      sidebery
#      vimium
    ];
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

  programs.wezterm = {
    enable = true;
    colorSchemes = {
      rainstorm = {
        ansi = [
          "#293146" "#ef7577" "#9dc3a1" "#c4be79"
          "#77addd" "#d5b2fa" "#a5e0dc" "#c0cfe1"
        ];
        brights = [
          "#3a4563" "#ef7577" "#9dc3a1" "#c4be79"
          "#77addd" "#d5b2fa" "#a5e0dc" "#d9e9fe"
        ];
        background = "#293146";
        foreground = "#d9e9fe";
      };
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };
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
      "text/plain" = [ "emacs.desktop" ];
      "inode/directory" = [ "thunar.desktop" ];
    };
  };
}
