{ pkgs, user, ... }:
let
  recordScreen = pkgs.writeShellScriptBin "wayland-record-screen" ''
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
  screenshot = pkgs.writeShellScriptBin "wayland-screenshot" ''
    sleep 1
    dimensions=$(slurp -d)
    if [ "$dimensions" ]
    then
      grim -g "$dimensions" - | swappy -f -
    fi
  '';
in
{
  home.packages = [ pkgs.wf-recorder pkgs.slurp pkgs.grim pkgs.swappy screenshot recordScreen ];
}
