{pkgs, config, lib, ...}:
let
  pythonPackages = p: with p; [
    dbus-python
    python-lsp-server
  ];
in
{
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
        "minecraft-launcher"
        "osu-lazer"
        "discord"
        "dwarf-fortress"
    ];

    home.packages = with pkgs; [
        #games
        lutris bottles gamescope xivlauncher
        steam onscripter-en discord gtkcord4 osu-lazer
        blesh airshipper (dwarf-fortress-packages.dwarf-fortress-full.override {
            enableFPS = true;
            enableIntro = true;
        })
        youtube-tui ani-cli minecraft fuzzel
        neovide
        xfce.thunar imv evince pavucontrol helvum
        blueberry wlogout zathura gimp
        libreoffice inkscape 
        openscad freecad hikari cura
        xdg-utils mpvpaper betterdiscordctl 
        #shell stuff
        thefuck tldr tremc

        cachix aria2 jetbrains.idea-community
        # text stuff
        texlive.combined.scheme-medium texlab emacs-all-the-icons-fonts dejavu_fonts dejavu_fontsEnv xits-math nerdfonts
        ##ltex-ls pandoc
        #config format stuff
        nil nixfmt taplo yaml-language-server marksman      
        #programming stuff
        git clang astyle
        maven openjdk19
        (python3.withPackages pythonPackages) coq agda idris2
    ] ++ (with rubyPackages_3_1; [
  ruby rufo
  solargraph
]) ++ (with nodePackages; [
  typescript-language-server
  vscode-langservers-extracted  
]) ++ (with luajitPackages; [
  lua stylua
  lua-lsp
]);
}
