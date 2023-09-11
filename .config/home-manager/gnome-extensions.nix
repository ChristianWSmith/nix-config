{ pkgs, ... }:
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
        ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      window-demands-attention-focus = true;
      workspace-switcher-size = 15;
      search = false;
      panel-size = 28;
    };
    "org/gnome/shell/extensions/pano" = {
      send-notification-on-copy = false;
      play-audio-on-copy = false;
    };
  };
}
