{ pkgs, theme, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = theme.iconThemePackage;
      name = theme.iconThemeName;
    };
    theme = {
      package = theme.themePackage;
      name = theme.themeName;
    };
    cursorTheme = {
      package = theme.cursorThemePackage;
      name = theme.cursorThemeName;
      size = theme.cursorSize;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    font = {
      package = theme.fontPackage;
      name = theme.fontName;
      size = theme.fontSize;
    };
  };

  qt = {
    enable = true;
    platformTheme = theme.qtPlatformTheme;
    style.name = theme.qtStyleName;
  };

  home.sessionVariables.GTK_THEME = theme.themeName;
}
