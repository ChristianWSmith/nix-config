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
  gtk.enable = true;
  gtk.font = {
    package = theme.fontPackage;
    name = theme.fontName;
    size = theme.fontSize;
  };
  gtk.theme.package = theme.themePackage;
  gtk.theme.name = theme.themeName;
  gtk.iconTheme.package = theme.iconThemePackage;
  gtk.iconTheme.name = theme.iconThemeName;
  gtk.gtk3.bookmarks = [
    "file://${user.home}/Documents Documents"
    "file://${user.home}/Downloads Downloads"
    "file://${user.home}/Music Music"
    "file://${user.home}/Pictures Pictures"
    "file://${user.home}/Templates Templates"
    "file://${user.home}/Videos Videos"
  ];
  qt.enable = true;
  qt.platformTheme = theme.qtPlatformTheme;
  qt.style.name = theme.qtStyleName;
}
