{ pkgs, userHome, ... }:
let
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    OS=$(cat /etc/os-release | grep -e "^NAME=" | sed s/NAME=//g)
    if [[ "$OS" == "NixOS" ]]
    then
      dbus-run-session ${pkgs.hyprland}/bin/Hyprland &> /dev/null
    else
      dbus-run-session nixGL ${pkgs.hyprland}/bin/Hyprland &> /dev/null
    fi
  '';
  enableScreenSharing = pkgs.writeShellScriptBin "hyprland-enable-screen-sharing" ''
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
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
        wf-recorder -g "$dimensions" -f ${userHome}/Videos/$filename
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
    ln -sf $(readlink -f $1) ${userHome}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  random-wallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    ln -sf $(echo ${userHome}/.wallpapers/$(ls ${userHome}/.wallpapers/ | sort -R | tail -1)) ${userHome}/.active-wallpaper
    pkill hyprpaper
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    wallpaper_dir=${userHome}/.config/home-manager/files/wallpapers
    got_wallpapers=${userHome}/.got-wallpapers
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
      source=${userHome}/.config/hypr/autoexec.conf
      source=${userHome}/.config/hypr/appearance.conf
      source=${userHome}/.config/hypr/input.conf
      source=${userHome}/.config/hypr/binds.conf
      source=${userHome}/.config/hypr/windowrules.conf
      source=${userHome}/.config/hypr/environment.conf
      source=/etc/display.conf
    '';
  };
}
