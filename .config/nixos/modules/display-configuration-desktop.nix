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
    "workspacebinds.conf" = {
      text = ''
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 7
        bind = $mainMod, 9, workspace, 7
        bind = $mainMod, 10, workspace, 7

        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 10, movetoworkspace, 10
      '';
    };
  };
}
