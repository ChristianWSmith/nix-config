{ pkgs, lib, userHome, ... }:
{
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.just-perfection
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.pano
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "just-perfection-desktop@just-perfection" 
        "blur-my-shell@aunetx" 
        "gnome-ui-tune@itstime.tech"
        "pano@elhan.io"
        "advanced-alt-tab@G-dH.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com" 
        "trayIconsReloaded@selfmade.pl"
        ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      window-demands-attention-focus = true;
      search = false;
      panel-size = 28;
      activities-button-icon-path = "file://${userHome}/.assets/nixos-icon.svg";
      activities-button-label = true;
      workspace-popup = false;
      workspaces-in-app-grid = false;
    };
    "org/gnome/shell/extensions/pano" = {
      send-notification-on-copy = false;
      play-audio-on-copy = false;
    };
    "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
      hot-edge-position = 0;
      switcher-popup-ext-app-favorites = false;
      app-switcher-popup-fav-apps = false;
      app-switcher-popup-include-show-apps-icon = false;
    };
    "org/gnome/shell/extensions/gnome-ui-tune" = {
      increase-thumbnails-size = "300%";
    };
  };
}
