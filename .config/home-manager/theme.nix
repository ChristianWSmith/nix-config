{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
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
    package = pkgs.cantarell-fonts;
    name = "Cantarell";
    size = 11;
  };
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3-dark";
  gtk.iconTheme.package = pkgs.gnome.adwaita-icon-theme;
  gtk.iconTheme.name = "Adwaita";
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
}
