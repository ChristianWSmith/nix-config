{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "thunderbird.desktop"
        "discord.desktop"
        "steam.desktop"
        "org.gnome.Console.desktop"
        "gnome-system-monitor.desktop"
        "org.gnome.Nautilus.desktop"
        ];
    };
    "org/gnome/desktop/interface/enable-hot-corners" = false;
    "org/gnome/mutter/dynamic-workspaces" = true;
    "org/gnome/mutter/workspaces-only-on-primary" = true;
    "org/gnome/desktop/session/idle-delay" = 0;
    "org/gnome/desktop/screensaver/lock-enabled" = false;
    "org/gnome/system/location/enabled" = true;
    "org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type" = "nothing";
    "org/gnome/settings-daemon/plugins/power/power-button-action" = "nothing";
    "org/gnome/desktop/datetime/automatic-timezone" = true;
    "org/gtk/settings/file-chooser/clock-format" = "12h";
    
  };
}