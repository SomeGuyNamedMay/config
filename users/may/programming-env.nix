{ pkgs, config, lib, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
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
        centaur-tabs
        rainbow-mode
        # keybindings and control
        meow
        aggressive-indent
        ace-window
        origami
        #notetaking stuff
        auctex
        latex-preview-pane
        #math-preview
        markdown-mode
        markdown-preview-mode
        markdownfmt
        #programming language modes and docs
        tldr
        lsp-java
        haskell-mode
        rust-mode
        #idris2-mode
        nix-mode
        lsp-mode
        lsp-ui
        lsp-origami
        proof-general
        company-coq
      ];
    extraConfig = builtins.readFile ./init.el;
  };
}
