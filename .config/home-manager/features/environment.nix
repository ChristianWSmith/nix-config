{ pkgs, theme, ... }:
{
  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    NIXPKGS_ALLOW_UNFREE = "1";
    NEWT_COLORS = ''
      root=${theme.colorScheme.newtAccent},${theme.colorScheme.newtBackground}
      border=${theme.colorScheme.newtAccent},${theme.colorScheme.newtBackground}
      title=${theme.colorScheme.newtAccent},${theme.colorScheme.newtBackground}
      roottext=${theme.colorScheme.newtForeground},${theme.colorScheme.newtBackground}
      window=${theme.colorScheme.newtAccent},${theme.colorScheme.newtBackground}
      textbox=${theme.colorScheme.newtForeground},${theme.colorScheme.newtBackground}
      button=${theme.colorScheme.newtBackground},${theme.colorScheme.newtAccent}
      compactbutton=${theme.colorScheme.newtForeground},${theme.colorScheme.newtBackground}
      listbox=${theme.colorScheme.newtForeground},${theme.colorScheme.newtBackground}
      actlistbox=${theme.colorScheme.newtBackground},${theme.colorScheme.newtForeground}
      actsellistbox=${theme.colorScheme.newtBackground},${theme.colorScheme.newtAccent}
      checkbox=${theme.colorScheme.newtAccent},${theme.colorScheme.newtBackground}
      actcheckbox=${theme.colorScheme.newtBackground},${theme.colorScheme.newtAccent}
    '';
  };
}
