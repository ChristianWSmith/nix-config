{ pkgs, userHome, iconTheme, font, ... }:
{
  home.pointerCursor = {
    # package = pkgs.gnome.adwaita-icon-theme;
    # name = "Adwaita";
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
  # gtk.theme.package = pkgs.adw-gtk3;
  # gtk.theme.name = "adw-gtk3-dark";
  gtk.theme.package = pkgs.whitesur-gtk-theme;
  gtk.theme.name = "WhiteSur-Dark";
  gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  gtk.iconTheme.name = iconTheme;
  gtk.gtk3.bookmarks = [
    "file://${userHome}/Documents"
    "file://${userHome}/Videos"
    "file://${userHome}/Music"
    "file://${userHome}/Downloads"
    "file://${userHome}/Templates"
    "file://${userHome}/Desktop"
  ];
  qt.enable = true;
  qt.platformTheme = "gtk";
  # qt.style.name = "adwaita-dark";
  qt.style.name = "WhiteSur-Dark";
}
