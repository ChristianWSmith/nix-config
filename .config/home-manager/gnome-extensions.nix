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
    gnomeExtensions.gtile
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "just-perfection-desktop@just-perfection" 
        "gTile@vibou"
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
    "org/gnome/shell/extensions/gtile" = {
      grid-sizes = "2x2";
      show-icon = false;
      auto-close-keyboard-shortcut = true;
      show-toggle-tiling = [ "<Super>t" ];
      show-toggle-tiling-alt = [ "" ];
      autotile-main = [ "" ];
      autotile-1 = [ "" ];
      autotile-2 = [ "" ];
      autotile-3 = [ "" ];
      autotile-4 = [ "" ];
      autotile-5 = [ "" ];
      autotile-6 = [ "" ];
      autotile-7 = [ "" ];
      autotile-8 = [ "" ];
      autotile-9 = [ "" ];
      autotile-10 = [ "" ];
      snap-to-neighbors = [ "" ];
      preset-resize-1 = [ "" ];
      preset-resize-2 = [ "" ];
      preset-resize-3 = [ "" ];
      preset-resize-4 = [ "" ];
      preset-resize-5 = [ "" ];
      preset-resize-6 = [ "" ];
      preset-resize-7 = [ "" ];
      preset-resize-8 = [ "" ];
      preset-resize-9 = [ "" ];
      preset-resize-10 = [ "" ];
      preset-resize-11 = [ "" ];
      preset-resize-12 = [ "" ];
      preset-resize-13 = [ "" ];
      preset-resize-14 = [ "" ];
      preset-resize-15 = [ "" ];
      preset-resize-16 = [ "" ];
      preset-resize-17 = [ "" ];
      preset-resize-18 = [ "" ];
      preset-resize-19 = [ "" ];
      preset-resize-20 = [ "" ];
      preset-resize-21 = [ "" ];
      preset-resize-22 = [ "" ];
      preset-resize-23 = [ "" ];
      preset-resize-24 = [ "" ];
      preset-resize-25 = [ "" ];
      preset-resize-26 = [ "" ];
      preset-resize-27 = [ "" ];
      preset-resize-28 = [ "" ];
      preset-resize-29 = [ "" ];
      preset-resize-30 = [ "" ];
      move-left-vi = [ "" ];
      move-right-vi = [ "" ];
      move-up-vi = [ "" ];
      move-down-vi = [ "" ];
      resize-left-vi = [ "" ];
      resize-right-vi = [ "" ];
      resize-up-vi = [ "" ];
      resize-down-vi = [ "" ];
    };
  };
}
