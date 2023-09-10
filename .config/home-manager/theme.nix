{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    cursorTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
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
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 11;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      favorite-apps = ["firefox.desktop' 'thunderbird.desktop" "discord.desktop" "steam.desktop" "org.gnome.Console.desktop" "gnome-system-monitor.desktop" "org.gnome.Nautilus.desktop"];
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";
  fonts.fontconfig.enable = true;
}
