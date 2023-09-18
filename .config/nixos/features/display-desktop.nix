{
  environment.etc = {
    "display.conf" = {
      text = ''
        monitor=DP-2, 1920x1080, 0x0, 1
        monitor=DP-1, 1920x1080@240, 1920x0, 1
        monitor=DP-3, 1920x1080, 3840x0, 1

        workspace=11,monitor:DP-2
        workspace=12,monitor:DP-3
        workspace=1,monitor:DP-1
        workspace=2,monitor:DP-1
        workspace=3,monitor:DP-1
        workspace=4,monitor:DP-1
        workspace=5,monitor:DP-1
        workspace=6,monitor:DP-1
        workspace=7,monitor:DP-1
        workspace=8,monitor:DP-1
        workspace=9,monitor:DP-1
        workspace=10,monitor:DP-1
        
	exec-once=xrandr --output DP-1 --primary
      '';
    };
  };
}
