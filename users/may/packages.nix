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
    ];

    home.packages = with pkgs; [
        #games
        lutris bottles gamescope xivlauncher
        steam onscripter-en discord osu-lazer
        blesh airshipper 
        ytfzf minecraft fuzzel

        xfce.thunar imv evince pavucontrol helvum
        blueberry wlogout fractal zathura gimp
        libreoffice inkscape 
        openscad freecad hikari cura
        xdg-utils mpvpaper betterdiscordctl 
        #shell stuff
        thefuck tldr 

        cachix aria2
        # text stuff
        texlive.combined.scheme-medium texlab
        ##ltex-ls pandoc
        #config format stuff
        nil nixfmt taplo yaml-language-server marksman      
        #programming stuff
        ghc cabal-install stack haskell-language-server stylish-haskell stack git
        rustc cargo rust-analyzer rustfmt clang astyle 
        maven openjdk jdt-language-server
        (python3.withPackages pythonPackages) coq
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
