{ pkgs, lib, config, ... }:

{
  home.sessionVariables = {
    TERMINAL = "wezterm";
    GTK_CSD = "0";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    zplug.plugins = [
      {
        name = "arzzen/calc.plugin.zsh";
      }
    ];
  };

  programs.nushell = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        bufferline = "multiple";
        cursorline = true;
        auto-format = true;
        color-modes = true;
        indent-guides.render = true;
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };
  programs.git = {
    enable = true;
    userName = "SomeGuyNamedMy";
    userEmail = "mfdear444@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = fromTOML (builtins.readFile ./starship.toml);
    #settings = {
    #  add_newline = false;
    #  continuation_prompt = "▶▶";
    #  format = lib.concatStrings [
    #    "[░▒▓](#a3aed2)"
    #    "[  ](bg:#a3aed2 fg:#090c0c)"
    #    "[](bg:#769ff0 fg:#a3aed2)"
    #    "$directory"
    #    "[](fg:#769ff0 bg:#394260)"
    #    "$git_branch"
    #    "$git_status"
    #    "[](fg:#394260 bg:#212736)"
    #    "$rust"
    #    "[](fg:#212736 bg:#1d2230)"
    #    "$sudo"
    #    "[ ](fg:#1d2230)"
    #    "\n$character"
    #  ];
    #  directory = {
    #    style = "fg:#e3e5e5 bg:#769ff0";
    #    format = "[ $path ]($style)";
    #    truncation_length = 3;
    #    truncation_symbol = "…/";
    #    substitutions = {
    #      Documents = " ";
    #      Downloads = " ";
    #      Music = " ";
    #      Pictures = " ";
    #    };
    #  };

    #  git_branch = {
    #    symbol = "";
    #    style = "bg:#394260";
    #    format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
    #  };

    #  git_status = {
    #    style = "bg:#394260";
    #    format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
    #  };

    #  rust = {
    #    symbol = "";
    #    style = "bg:#212736";
    #    format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
    #  };
    #  
    #  sudo = {
    #    style = "bold green";
    #    symbol = "";
    #    disabled = false;
    #    format = "[[ $symbol ](fg:#769ff0 bg:#1d2230)]($style)";
    #  };

    #  character = {
    #    success_symbol = "";
    #    error_symbol = "";
    #  };
    #};
  };
}
