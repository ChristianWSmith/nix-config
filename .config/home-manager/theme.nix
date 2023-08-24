{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  gtk.enable = true;
  gtk.font = {
    package = pkgs.noto-fonts;
    name = "Noto Sans";
    size = 11;
  };
  gtk.cursorTheme.package = pkgs.gnome.adwaita-icon-theme;
  gtk.cursorTheme.name = "Adwaita";
  gtk.cursorTheme.size = 40;
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3-dark";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
}
