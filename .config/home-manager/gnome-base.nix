{ lib, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      enable-animations = true;
      clock-format = "12h";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "thunderbird.desktop"
        "discord.desktop"
        "steam.desktop"
        "codium.desktop"
        "org.gnome.Console.desktop"
        "gnome-system-monitor.desktop"
        "org.gnome.Nautilus.desktop"
        ];
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      workspaces-only-on-primary = true;
      edge-tiling = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
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
    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Characters.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      close = [ "<Shift><Super>q" ];
      toggle-fullscreen = [ "<Super>f" ];
      move-to-monitor-up = [ "<Shift><Super>i" ];
      move-to-monitor-down = [ "<Shift><Super>k" ];
      move-to-monitor-left = [ "<Shift><Super>j" ];
      move-to-monitor-right = [ "<Shift><Super>l" ];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      show-screenshot-ui = [ "<Super>s" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      command = "kgx";
      binding = "<Super>Return";
      name = "Console";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      command = "nautilus";
      binding = "<Super>e";
      name = "Files";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      command = "firefox";
      binding = "<Super>w";
      name = "Browser";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      command = "gnome-system-monitor";
      binding = "<Super>b";
      name = "System Monitor";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      command = "dbus-send --session --type=method_call --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Shutdown";
      binding = "<Shift><Super>e";
      name = "Shutdown";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      command = "dbus-send --session --type=method_call --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Reboot";
      binding = "<Shift><Super>r";
      name = "Reboot";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
         "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
         "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
      ];
    };
  };
}
