{ pkgs, ... }:
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
    dimensions=$(slurp -d)
    if [ "$dimensions" ]
    then
      grim -g "$dimensions" - | swappy -f -
    fi
  '';
  recordScreen = pkgs.writeShellScriptBin "record-screen" ''
    PIDFILE="/tmp/wf-recorder.pid"
    COMMAND="${pkgs.wf-recorder}/bin/wf-recorder"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
      notify-send "Screen recording ended."
    else
      echo "$$" > $PIDFILE
      notify-send "Screen recording started."
      $COMMAND
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
      source=~/.config/hypr/autoexec.conf
      source=~/.config/hypr/appearance.conf
      source=~/.config/hypr/input.conf
      source=~/.config/hypr/binds.conf
      source=~/.config/hypr/windowrules.conf
      source=~/.config/hypr/environment.conf 
    '';
  };
}
