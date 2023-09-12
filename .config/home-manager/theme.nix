{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      # package = pkgs.marwaita;
      # name = "Marwaita Color Dark";
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      # package = pkgs.capitaine-cursors;
      # name = "capitaine-cursors";
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
  # home.sessionVariables.GTK_THEME = "Marwaita Color Dark";
}
