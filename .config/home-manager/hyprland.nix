{ pkgs, user, ... }:
let
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    dbus-run-session ${pkgs.hyprland}/bin/Hyprland &> /dev/null
  '';
  enableScreenSharing = pkgs.writeShellScriptBin "hyprland-enable-screen-sharing" ''
    systemctl --user stop xdg-desktop-portal
    systemctl --user stop xdg-desktop-portal-hyprland
    sleep 5
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    sleep 5
    systemctl --user start xdg-desktop-portal
    systemctl --user start xdg-desktop-portal-hyprland
  '';
  screenshot = pkgs.writeShellScriptBin "hyprland-screenshot" ''
    sleep 1
    dimensions=$(slurp -d)
    if [ "$dimensions" ]
    then
      grim -g "$dimensions" - | swappy -f -
    fi
  '';
  recordScreen = pkgs.writeShellScriptBin "record-screen" ''
    PIDFILE="/tmp/record-screen.pid"
    if ps -p $(cat $PIDFILE);
    then
      kill -SIGINT $(pgrep wf-recorder)
      notify-send "Screen recording ended."
    else
      echo "$$" > $PIDFILE
      sleep 1
      dimensions=$(slurp -d)
      if [ "$dimensions" ]
      then
        filename="recording-$(date +%s).mp4"
        notify-send "Screen recording started: ~/Videos/$filename"
        wf-recorder -g "$dimensions" -f ${user.home}/Videos/$filename
      else
        notify-send "Screen recording cancelled."
      fi
    fi
  '';
  colorPicker = pkgs.writeShellScriptBin "hyprland-colorpicker" ''
    hyprpicker | tr -d '\n' | wl-copy
    notify-clipboard
  '';
  notifyClipboard = pkgs.writeShellScriptBin "notify-clipboard" ''
    paste=$(wl-paste)

    if [ "$paste" ]
    then
      notify-send "Clipboard: $paste"
    fi
  '';
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ln -sf $(readlink -f $1) ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  random-wallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    ln -sf $(echo ${user.home}/.wallpapers/$(ls ${user.home}/.wallpapers/ | sort -R | tail -1)) ${user.home}/.active-wallpaper
    pkill hyprpaper
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    wallpaper_dir=${user.home}/.config/home-manager/files/wallpapers
    got_wallpapers=${user.home}/.got-wallpapers
    if [ -f $got_wallpapers ]
    then
      exit
    fi
    # wget -nc -O $wallpaper_dir/<image_name> <url>
    touch $got_wallpapers
  '';
in
{
  home.file = {
    ".tty1-gui-only".text = "";
  };
  home.packages = [ launcher screenshot enableScreenSharing colorPicker notifyClipboard recordScreen set-wallpaper random-wallpaper get-wallpapers ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      source=${user.home}/.config/hypr/autoexec.conf
      source=${user.home}/.config/hypr/appearance.conf
      source=${user.home}/.config/hypr/input.conf
      source=${user.home}/.config/hypr/binds.conf
      source=${user.home}/.config/hypr/windowrules.conf
      source=${user.home}/.config/hypr/environment.conf
      source=/etc/workspacebinds.conf
      source=/etc/display.conf
    '';
  };
}
