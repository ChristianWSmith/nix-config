{ pkgs, userHome, ... }:
let
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    OS=$(cat /etc/os-release | grep -e "^NAME=" | sed s/NAME=//g)
    if [[ "$OS" == "NixOS" ]]
    then
      ${pkgs.hyprland}/bin/Hyprland &> /dev/null
    else
      nixGL ${pkgs.hyprland}/bin/Hyprland &> /dev/null
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
in
{
  home.packages = [ launcher screenshot enableScreenSharing colorPicker notifyClipboard recordScreen ];
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
