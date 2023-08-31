{ pkgs, config, userHome, font, ... }:
let
  pidFile = "/tmp/rofi.pid";
  appLauncher = pkgs.writeShellScriptBin "app-launcher" ''
    PIDFILE="${pidFile}"
    COMMAND="rofi -show drun -drun-categories AudioVideo,Audio,Video,Development,Education,Game,Graphics,Network,Office,Science,Settings,System,Utility -theme ${userHome}/.config/rofi/launcher.rasi"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
    else
      echo "$$" > $PIDFILE
      $COMMAND
    fi
  '';

  powerMenu = pkgs.writeShellScriptBin "power-menu" ''
    PIDFILE="${pidFile}"
    COMMAND="rofi -show drun -drun-categories Session -theme ${userHome}/.config/rofi/powermenu.rasi"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
    else
      echo "$$" > $PIDFILE
      $COMMAND
    fi
  '';

  rofimoji = pkgs.writeShellScriptBin "emoji" ''
    PIDFILE="${pidFile}"
    if ps -p $(cat $PIDFILE);
    then
      pkill rofimoji
    else
      echo "$$" > $PIDFILE
      rofimoji --selector-args "-theme ${userHome}/.config/rofi/picker.rasi" --action $1
      if [ "$1" == "copy" ]
      then
        notify-clipboard
      fi
    fi
  '';

  clipboard = pkgs.writeShellScriptBin "clipboard-picker" ''
    PIDFILE="${pidFile}"
    if ps -p $(cat $PIDFILE);
    then
      kill $(cat $PIDFILE)
    else
      echo "$$" > $PIDFILE
      cliphist list | rofi -theme ${userHome}/.config/rofi/picker.rasi -dmenu -p ">" | cliphist decode | wl-copy
    fi

  '';

  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    rofi -dmenu $@
  '';
in
{
  home.packages = [ appLauncher powerMenu dmenu rofimoji clipboard ];

  home.file = {
    ".local/share/applications/poweroff.desktop".text = ''
      [Desktop Entry]
      Name=Power Off
      Comment=Turn off the system.
      Exec=poweroff
      Icon=system-shutdown-symbolic
      Terminal=false
      Type=Application
      Categories=Session;
    '';
    ".local/share/applications/reboot.desktop".text = ''
      [Desktop Entry]
      Name=Reboot
      Comment=Reboot the system.
      Exec=reboot
      Icon=system-reboot-symbolic
      Terminal=false
      Type=Application
      Categories=Session;
    '';
    ".local/share/applications/lock.desktop".text = ''
      [Desktop Entry]
      Name=Lock
      Comment=Lock the screen.
      Exec=gtklock
      Icon=system-lock-screen-symbolic
      Terminal=false
      Type=Application
      Categories=Session;
    '';
  };

  programs.rofi.enable = true;

  programs.rofi.theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      
      "*" = {
          background = mkLiteral "#1E2127FF";
          background-alt = mkLiteral "#282B31FF";
          foreground = mkLiteral "#FFFFFFFF";
          selected = mkLiteral "#61AFEFFF";
          active = mkLiteral "#98C379FF";
          urgent = mkLiteral "#E06C75FF";
          font = "${font} 11";
      };
      
    };
}
