{ pkgs, ... }:
let
  xboxdrvRunFile = "/ram/hitbox_xboxdrv.run";
  deviceMonitorRunFile = "/ram/hitbox_device_monitor.run";
  pidFile = "/ram/hitbox.pid";
  hitbox = pkgs.writeShellScriptBin "hitbox" ''

xboxdrv_keepalive () {
  while [ -e /dev/input/$1 ] && [ -e ${xboxdrvRunFile} ]
  do
    xboxdrv --evdev /dev/input/$1 --evdev-keymap "BTN_TRIGGER=A,BTN_THUMB2=X,BTN_TOP=Y,BTN_THUMB=B,BTN_PINKIE=LB,BTN_TOP2=RB,BTN_BASE2=LT,BTN_BASE=RT,BTN_BASE5=TL,BTN_BASE6=TR,BTN_BASE3=Back,BTN_BASE4=Start" --evdev-absmap "ABS_X=x1,ABS_Y=y1" --axismap "-y1=y1" --mimic-xpad --silent
  done
}

device_monitor() {
  while [ -e ${deviceMonitorRunFile} ]
  do
    EVENT_ID=$(cat /proc/bus/input/devices | grep "DragonRise" -A 4 | grep "H: Handlers" | cut -d'=' -f2 | cut -d' ' -f1)

    if [[ ! -z "$EVENT_ID" ]]
    then
      touch ${xboxdrvRunFile}
      xboxdrv_keepalive $EVENT_ID &
      inotifywait -e attrib /dev/input/$EVENT_ID
      rm ${xboxdrvRunFile}
      pkill -9 xboxdrv
    fi
  
    inotifywait -e create /dev/input
    sleep 1
  done
}

main () {
  if ! [ -e ${pidFile} ]
  then
    echo "0" > ${pidFile}
  fi
  if ps $(cat ${pidFile})
  then
    echo "Already running."
    exit
  else
    echo $$ > ${pidFile}
  fi
  touch ${deviceMonitorRunFile}
  device_monitor &
  sh -c "$(echo $@)"
  rm ${deviceMonitorRunFile}
  while pgrep xboxdrv || pgrep inotifywait
  do
    pkill xboxdrv
    pkill inotifywait
    sleep 1
  done
}

main $@

  '';
in
{
  home.packages = [ hitbox ];
}
