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
      source=/etc/display.conf
    '';
  };
}
