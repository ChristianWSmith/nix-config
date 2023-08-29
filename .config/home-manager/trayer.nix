{ pkgs, ... }:
let
  tray = pkgs.writeShellScriptBin "system-tray" ''
    PIDFILE="/tmp/system-tray.pid"
    COMMAND="trayer --alpha 0 --tint 0xcc1e1e1e --transparent true --height 40 --width 10 --distance 5"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
    else
      echo "$$" > $PIDFILE
      $COMMAND
    fi
  '';
in
{
  home.packages = [ tray ];
  services.trayer.enable = true;
}
