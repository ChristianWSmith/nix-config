{ pkgs, lib, userHome, ... }:
{
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.just-perfection
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
        "drive-menu@gnome-shell-extensions.gcampax.github.com" 
        "trayIconsReloaded@selfmade.pl"
        "pano@elhan.io"
        "color-picker@tuberry"
        "advanced-alt-tab@G-dH.github.com"
        ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      window-demands-attention-focus = true;
      workspace-switcher-size = 15;
      search = false;
      panel-size = 28;
      activities-button-icon-path = "${userHome}/.assets/nixos-icon.svg";
      activities-button-label = false;
      workspace-popup = false;
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
  };
}
