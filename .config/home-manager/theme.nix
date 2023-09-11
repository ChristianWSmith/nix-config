{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme; # pkgs.whitesur-icon-theme;
      name = "Adwaita"; # "WhiteSur-dark";
    };
    theme = {
      package = pkgs.adw-gtk3; # pkgs.whitesur-gtk-theme;
      name = "adw-gtk3-dark"; # "WhiteSur-Dark";
    };
    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme; # pkgs.capitaine-cursors;
      name = "Adwaita"; # "capitaine-cursors";
      size = 40;
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
      package = pkgs.cantarell-fonts; # pkgs.noto-fonts;
      name = "Cantarell"; # "Noto Sans";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";
}
