{ pkgs, user, theme, ... }:
let
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    ${pkgs.hyprland}/bin/Hyprland &> /dev/null
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
        wf-recorder -g "$dimensions" -f ${user.home}/Videos/$filename
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
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ln -sf $(readlink -f $1) ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  random-wallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    ln -sf $(echo ${user.home}/.wallpapers/$(ls ${user.home}/.wallpapers/ | sort -R | tail -1)) ${user.home}/.active-wallpaper
    pkill hyprpaper
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    wallpaper_dir=${user.home}/.config/home-manager/files/wallpapers
    got_wallpapers=${user.home}/.got-wallpapers
    if [ -f $got_wallpapers ]
    then
      exit
    fi
    # wget -nc -O $wallpaper_dir/<image_name> <url>
    touch $got_wallpapers
  '';
in
{
  home.file = {
    ".tty1-gui-only".text = "";
    ".config/hypr/autoexec.conf".text = ''
      exec-once = foot --server
      exec-once = hyprpaper
      exec-once = waybar
      exec-once = hyprland-enable-screen-sharing
      exec-once = wl-paste --watch cliphist store
      exec-once = mkdir -p $HOME/Pictures $HOME/Documents $HOME/Videos $HOME/Music $HOME/Downloads $HOME/Templates $HOME/Desktop
    '';
    ".config/hypr/binds.conf".text = ''
      $mainMod = SUPER
      bind = $mainMod, RETURN, exec, terminal
      bind = $mainMod, W, exec, $BROWSER
      bind = $mainMod, E, exec, nemo
      bind = $mainMod, S, exec, hyprland-screenshot
      bind = $mainMod, P, exec, hyprland-colorpicker
      bind = $mainMod, A, exec, terminal pulsemixer
      bind = $mainMod, D, exec, app-launcher
      bind = $mainMod, T, exec, system-tray
      bind = $mainMod, B, exec, terminal btop
      bind = $mainMod, Z, exec, zen-toggle
      bind = $mainMod, O, exec, emoji type

      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod SHIFT, E, exec, power-menu
      bind = $mainMod, SPACE, togglefloating,
      bind = $mainMod, F, fullscreen,

      bind = $mainMod, J, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, I, movefocus, u
      bind = $mainMod, K, movefocus, d

      bind = $mainMod SHIFT, J, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r
      bind = $mainMod SHIFT, I, movewindow, u
      bind = $mainMod SHIFT, K, movewindow, d

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
    '';
    ".config/hypr/environment.conf".text = '''';
    ".config/hypr/input.conf".text = ''
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          follow_mouse = 1
          touchpad {
              natural_scroll = true
          }
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      gestures {
          workspace_swipe = false
      }
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }
    '';
    ".config/hypr/windowrules.conf".text = ''
      windowrulev2 = move 100% 100%,class:(trayer),title:(panel)
      windowrulev2 = float,class:(trayer),title:(panel)
      windowrulev2 = pin,class:(trayer),title:(panel)
      windowrulev2 = float,class:(wlogout),title:(wlogout)
      windowrulev2 = noanim,class:(wlogout),title:(wlogout)
    '';
    ".config/hypr/appearance.conf".text = ''
      blurls=waybar
      layerrule=ignorezero, waybar
      general {
          gaps_in = 3
          gaps_out = 5
          border_size = 1
          col.active_border = rgba(${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}) rgba(${theme.colorScheme.secondaryAccentHex}${theme.colorScheme.transparencyForegroundHex}) 45deg
          col.inactive_border = rgba(${theme.colorScheme.background4Hex}${theme.colorScheme.transparencyBackgroundHex})

          layout = dwindle
      }
      decoration {
          rounding = ${builtins.toString theme.borderRadius}
          blur {
              enabled = true
              size = 3
              passes = 1
          }
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyBackgroundHex})
      }
      animations {
          enabled = true
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, myBezier, slide
      }
      dwindle {
          pseudotile = true
          preserve_split = true
      }
      master {
          new_is_master = false
      }
      gestures {
          workspace_swipe = false
      }
      misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          force_hypr_chan = false
      }
    '';
  };
  home.packages = [ launcher screenshot enableScreenSharing colorPicker notifyClipboard recordScreen set-wallpaper random-wallpaper get-wallpapers ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      source=${user.home}/.config/hypr/autoexec.conf
      source=${user.home}/.config/hypr/appearance.conf
      source=${user.home}/.config/hypr/input.conf
      source=${user.home}/.config/hypr/binds.conf
      source=${user.home}/.config/hypr/windowrules.conf
      source=${user.home}/.config/hypr/environment.conf
      source=${user.home}/.config/hypr/extra.conf
      source=/etc/display.conf
    '';
  };
}
