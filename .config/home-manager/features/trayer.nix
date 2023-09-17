{ pkgs, ... }:
let
  lockFile = "/ram/trayer.lock";
  tray = pkgs.writeShellScriptBin "system-tray" ''
    touch ${lockFile}
    COMMAND="trayer --monitor 0 --alpha 0 --tint 0xcc1e1e1e --transparent true --height 40 --width 10 --distance 5"
    FLOCK_COMMAND="flock -n ${lockFile} $COMMAND"
    LOCKING_PIDS=$(lsof -t ${lockFile})
    if [ "$LOCKING_PIDS" ]
    then
      kill -SIGINT $LOCKING_PIDS
    else
      if ! lsof -t ${lockFile}
      then
        bash -c "$FLOCK_COMMAND"
      fi
    fi
  '';
in
{
  home.packages = [ tray ];
  services.trayer.enable = true;
}
