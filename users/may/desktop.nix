{ pkgs, lib, config, ... }: # my-wallpapers, ... }:

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
    "org/gnome/desktop/wm/preferences" = { button-layout = "menu:appmenu"; };
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
    extraConfig = builtins.readFile ./hyprland.conf + ''
      bind=SUPER_SHIFT,Q,exec,${pkgs.wlogout}/bin/wlogout
    '' + ''
      bind=SUPER,SPACE,exec,rofi -show
    '';
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
        modules-left = [ "user" "wlr/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "wireplumber" "network" "upower" "clock" ];
        "user" = {
          format = "{user}";
          interval = 60;
          height = 30;
          width = 30;
          icon = true;
        };
        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = " ";
          on-click = "helvum";
          format-icons = [ " " " " " " ];
        };
        "upower" = {
          icon-size = 20;
          hide-if-empty = false;
        };
        "network" = {
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "{ipaddr}/{cidr}  ";
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
  services.network-manager-applet.enable = true;

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

  programs.wlogout = { enable = true; };
  services.avizo = { enable = true; };

  programs.qutebrowser = {
    enable = true;
    settings = { scrolling.smooth = true; };
  };
  programs.chromium.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      mason = {
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://github.com/SomeGuyNamedMy/";
          "browser.tabs.tabmanager.enabled" = false;
          # privacy stuff
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          # As well as Firefox 'experiments'
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "network.allow-experiments" = false;

          # Disable Pocket Integration
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "";

          #enable theming
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "svg.context-properties.content.enabled" = true;
        };
        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          stylus
          tree-style-tab
          vimium
        ];
        userChrome = ''
          #TabsToolbar {
            visibility: collapse;
          }
        '';
      };
    };
  };

  programs.zathura = { enable = true; };

  programs.kitty = {
    enable = true;
    font.size = 14;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
  };

  programs.foot.enable = true;

  services.mako = { enable = true; };
  services.udiskie.enable = true;
  services.poweralertd.enable = true;

  programs.mpv = { enable = true; };

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
