{ pkgs, config, userHome, font, ... }:
let
  lockFile = "/ram/rofi.lock";

  _rofiBroker = pkgs.writeShellScriptBin "rb" ''
    touch ${lockFile}
    COMMAND="$@"
    FLOCK_COMMAND="flock -n ${lockFile} $COMMAND"
    LOCKING_PIDS=$(lsof -t ${lockFile})
    if [ "$LOCKING_PIDS" ]
    then
      kill -SIGINT $LOCKING_PIDS
    fi
    if ! lsof -t ${lockFile}
    then
      bash -c "$FLOCK_COMMAND"
    fi
  '';

  appLauncher = pkgs.writeShellScriptBin "app-launcher" ''
    COMMAND="rofi -show drun -drun-categories AudioVideo,Audio,Video,Development,Education,Game,Graphics,Network,Office,Science,Settings,System,Utility -theme ${userHome}/.config/rofi/launcher.rasi"
    ${_rofiBroker}/bin/rb $COMMAND
  '';

  powerMenu = pkgs.writeShellScriptBin "power-menu" ''
    COMMAND="rofi -show drun -drun-categories Session -theme ${userHome}/.config/rofi/powermenu.rasi -sort"
    ${_rofiBroker}/bin/rb $COMMAND
  '';

  rofimoji = pkgs.writeShellScriptBin "emoji" ''
    COMMAND='rofimoji --selector-args "-theme ${userHome}/.config/rofi/picker.rasi" --action'
    ${_rofiBroker}/bin/rb $COMMAND $1
  '';

  clipboard = pkgs.writeShellScriptBin "clipboard-picker" ''
    COMMAND='cliphist list | rofi -theme ${userHome}/.config/rofi/picker.rasi -dmenu -p ">" | cliphist decode | wl-copy'
    ${_rofiBroker}/bin/rb $COMMAND
  '';

  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    COMMAND="rofi -dmenu $@"
    ${_rofiBroker}/bin/rb $COMMAND
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
