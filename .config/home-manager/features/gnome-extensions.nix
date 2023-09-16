{ pkgs, lib, user, theme, ... }:
{
  home.packages = with pkgs; [
    gnome-extension-manager
    gnome.gnome-tweaks
    gnomeExtensions.just-perfection
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.pano
    gnomeExtensions.forge
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.quick-settings-tweaker
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "just-perfection-desktop@just-perfection"
        "gnomeExtensions.custom-accent-colors"
        "blur-my-shell@aunetx" 
        "gnome-ui-tune@itstime.tech"
        "rounded-window-corners@yilozt"
        "quick-settings-tweaks@qwreey"
        "advanced-alt-tab@G-dH.github.com"
        "pano@elhan.io"
        "drive-menu@gnome-shell-extensions.gcampax.github.com" 
        "trayIconsReloaded@selfmade.pl"
        "forge@jmmaranan.com"
        ];
    };
    "org/gnome/shell/extensions/forge" = {
      auto-split-enabled = true;
      focus-border-toggle = false;
      preview-hint-enabled = true;
      quick-settings-enabled = false;
      split-border-toggle = true;
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      window-gap-size = lib.hm.gvariant.mkUint32 4;
      window-gap-size-increment = lib.hm.gvariant.mkUint32 1;
    };
    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [];
      con-split-layout-toggle = [];
      con-split-vertical = [];
      con-stacked-layout-toggle = [];
      con-tabbed-layout-toggle = [];
      con-tabbed-showtab-decoration-toggle = [];
      focus-border-toggle = [];
      prefs-open = [];
      prefs-tiling-toggle = [];
      window-focus-down = [];
      window-focus-left = [];
      window-focus-right = [];
      window-focus-up = [];
      window-gap-size-decrease = [];
      window-gap-size-increase = [];
      window-move-down = [];
      window-move-left = [];
      window-move-right = [];
      window-move-up = [];
      window-resize-bottom-decrease = [];
      window-resize-bottom-increase = [];
      window-resize-left-decrease = [];
      window-resize-left-increase = [];
      window-resize-right-decrease = [];
      window-resize-right-increase = [];
      window-resize-top-decrease = [];
      window-resize-top-increase = [];
      window-snap-center = [];
      window-snap-one-third-left = [];
      window-snap-one-third-right = [];
      window-snap-two-third-left = [];
      window-snap-two-third-right = [];
      window-swap-down = [];
      window-swap-last-active = [];
      window-swap-left = [];
      window-swap-right = [];
      window-swap-up = [];
      window-toggle-always-float = [];
      window-toggle-float = [ "<Super>s" ];
      workspace-active-tile-toggle = [];
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      static-blur = true;
    };
    "org/gnome/shell/extensions/rounded-window-corners" = {
      border-width = 1;
      border-color = lib.hm.gvariant.mkTuple [0.0 0.0 0.0 1.0];
      custom-rounded-corner-settings = "@a{sv} {}";
      focused-shadow = "{'vertical_offset': 4, 'horizontal_offset': 0, 'blur_offset': 28, 'spread_radius': 4, 'opacity': 60}";
      global-rounded-corner-settings = "{'padding': <{'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keep_rounded_corners': <{'maximized': <false>, 'fullscreen': <false>}>, 'border_radius': <uint32 8>, 'smoothing': <uint32 0>, 'enabled': <true>}";
      settings-version = lib.hm.gvariant.mkUint32 5;
      skip-libadwaita-app = false;
      skip-libhandy-app = false;
      unfocused-shadow = "{'horizontal_offset': 0, 'vertical_offset': 2, 'blur_offset': 12, 'spread_radius': -1, 'opacity': 65}";
    };
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      user-removed-buttons = [ "DarkModeToggle" ];
      input-always-show = true;
      datemenu-remove-notifications = false;
      notifications-enabled = false;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      window-preview-caption = false;
      activities-button-icon-monochrome = true;
      window-demands-attention-focus = true;
      search = false;
      panel-size = 28;
      activities-button-icon-path = "file://${user.home}/.assets/nixos-icon-white.svg";
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
