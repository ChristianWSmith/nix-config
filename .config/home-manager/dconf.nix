{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.just-perfection
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
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
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
      edge-tiling = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = 0;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "nothing";
      sleep-inactive-battery-type = "nothing";
      power-saver-profile-on-low-battery = false;
      idle-dim = false;
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
    };
  };
}
