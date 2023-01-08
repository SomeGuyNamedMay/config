{ pkgs, config, lib, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs:
      with epkgs; [
        # theming and ui
        ligature
        unicode-fonts
        all-the-icons
        autothemer
        nord-theme
        dirvish
        doom-modeline
        dashboard
        selectrum
        orderless
        prescient
        flycheck
        rainbow-mode
        # keybindings and control
        meow
        aggressive-indent
        ace-window
        origami
        #programming language modes and docs
        tldr
        haskell-mode
        rust-mode
        idris2-mode
        nix-mode
        lsp-mode
        lsp-ui
        lsp-origami
      ];
    extraConfig = builtins.readFile ./init.el;
  };
}
