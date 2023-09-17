{ pkgs, user, theme, ... }:
{
  home.pointerCursor = {
    package = theme.cursorThemePackage;
    name = theme.cursorThemeName;
    size = theme.cursorSize;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  fonts.fontconfig.enable = true;
  
  gtk = {
    enable = true;
    font = {
      package = theme.fontPackage;
      name = theme.fontName;
      size = theme.fontSize;
    };
    theme.package = theme.themePackage;
    theme.name = theme.themeName;
    iconTheme.package = theme.iconThemePackage;
    iconTheme.name = theme.iconThemeName;
    gtk3.bookmarks = [
      "file://${user.home}/Documents Documents"
      "file://${user.home}/Downloads Downloads"
      "file://${user.home}/Music Music"
      "file://${user.home}/Pictures Pictures"
      "file://${user.home}/Templates Templates"
      "file://${user.home}/Videos Videos"
    ];
  };

  qt = {
    enable = true;
    platformTheme = theme.qtPlatformTheme;
    style.name = theme.qtStyleName;
  };
}
