{ pkgs, userHome, iconTheme, font, ... }:
{
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 40;
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
  fonts.fontconfig.enable = true;
  gtk.enable = true;
  gtk.font = {
    package = pkgs.noto-fonts;
    name = "${font}";
    size = 11;
  };
  gtk.theme.package = pkgs.whitesur-gtk-theme;
  gtk.theme.name = "WhiteSur-Dark";
  gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  gtk.iconTheme.name = iconTheme;
  gtk.gtk3.bookmarks = [
    "file://${userHome}/Documents Documents"
    "file://${userHome}/Downloads Downloads"
    "file://${userHome}/Music Music"
    "file://${userHome}/Pictures Pictures"
    "file://${userHome}/Templates Templates"
    "file://${userHome}/Videos Videos"
  ];
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "WhiteSur-Dark";
}
