{pkgs, config, lib, ...}:

{
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
        "minecraft-launcher"
        "osu-lazer"
        "discord"
    ];

    home.packages = with pkgs; [
        #games
        lutris bottles gamescope xivlauncher
        steam onscripter-en discord
        blesh airshipper osu-lazer xonotic

        ytfzf minecraft fuzzel

        xfce.thunar imv evince pavucontrol
        blueberry wlogout fractal zathura
        libreoffice inkscape blender
        openscad freecad hikari cura
        xdg-utils mpvpaper betterdiscordctl 
        #shell stuff
        thefuck tldr 

        cachix aria2
        # text stuff
        ##texlive.combined.scheme-medium texlab
        ##ltex-ls pandoc
        #programming stuff
        ghc cabal-install stack haskell-language-server stylish-haskell stack git
        rustc cargo rust-analyzer rustfmt clang astyle rnix-lsp nixfmt
    ] ++ (with python39Packages; [
      python  yapf
      python-lsp-server
    ])
++ (with rubyPackages_3_1; [
  ruby rufo
  solargraph
]) ++ (with luajitPackages; [
  lua stylua
  lua-lsp
]);
}
