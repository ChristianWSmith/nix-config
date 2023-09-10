{ pkgs, userHome, iconTheme, theme, font, ... }:
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
  gtk.theme.name = theme;
  gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  gtk.iconTheme.name = iconTheme;
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = theme;
}
