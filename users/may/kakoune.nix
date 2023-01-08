{pkgs, lib, config, ...}:
let
  kakoune-idris = pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
      pname = "kakoune-idris";
      version = "0.0.0";
      src = pkgs.fetchFromGitHub {
          owner = "stoand";
          repo = "kakoune-idris";
          rev = "bf1d1e34229e71c27b33dec00655b03b9679634c";
          sha256 = "EeRAF5S4az7ikQkLO1JeIkEzPAb9QPhW2fhAjSEE4wI=";
      };
      meta.homepage = "https://github.com/stoand/kakoune-idris/";
  };
in
{
    programs.kakoune = {
        enable = true;
        config = {
            hooks = [
                {
                    name = "WinSetOption";
                    group = "global";
                    option = "filetype=(rust|c|cpp|haskell)";
                    commands = "lsp-enable-window";
                }
            ];
            numberLines.enable = true;
            numberLines.highlightCursor = true;
            numberLines.relative = true;
            ui.assistant = "cat";
            ui.setTitle = true;
            ui.statusLine = "top";
            wrapLines.enable = true;
        };
        plugins = with pkgs.kakounePlugins; [
            kak-lsp
            kak-fzf
            powerline-kak
            kakoune-idris
            auto-pairs-kak
            openscad-kak
            kakoune-rainbow
        ];
        extraConfig = ''
        eval %sh{kak-lsp --kakoune -s $kak_session}
        powerline-start
        '';
    };
}
