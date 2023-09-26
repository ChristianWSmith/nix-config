{ pkgs, user, theme, ... }:
let
  extraConfig = pkgs.writeShellScriptBin "hyprland-extra-config" ''
    if ! [ -f ${user.home}/.config/hypr/extra.conf ]; then
      touch ${user.home}/.config/hypr/extra.conf
      hyprctl reload
    fi
  '';
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
    . "${user.home}/.nix-profile/etc/profile.d/hm-session-vars.sh"
    dbus-run-session ${pkgs.hyprland}/bin/Hyprland &> /dev/null
  '';
  startPortals = pkgs.writeShellScriptBin "start-portals" ''
    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user start xdg-desktop-portal
    systemctl --user start xdg-desktop-portal-hyprland
  '';
  colorPicker = pkgs.writeShellScriptBin "wayland-colorpicker" ''
    hyprpicker | tr -d '\n' | wl-copy
    notify-clipboard
  '';
in
{
  home.file = {
    ".tty1-gui-only".text = "";
    ".wallpapers/default.png".source = ../files/wallpapers/default.png;
    ".config/hypr/autoexec.conf".text = ''
      exec-once = hyprland-extra-config
      exec-once = foot --server
      exec-once = get-wallpapers
      exec-once = random-wallpaper
      exec-once = waybar
      exec-once = start-portals
      exec-once = wl-paste --watch cliphist store
      exec-once = mount-google-drive
      exec-once = mkdir -p ${user.home}/Pictures ${user.home}/Documents ${user.home}/Videos ${user.home}/Music ${user.home}/Downloads ${user.home}/Templates ${user.home}/Desktop ${user.home}/Public ${user.home}/GitHub
    '';
    ".config/hypr/binds.conf".text = ''
      $mainMod = SUPER
      bind = $mainMod, RETURN, exec, terminal
      bind = $mainMod, W, exec, $BROWSER
      bind = $mainMod, E, exec, terminal ranger
      bind = $mainMod, S, exec, wayland-screenshot
      bind = $mainMod, P, exec, wayland-colorpicker
      bind = $mainMod, A, exec, terminal pulsemixer
      bind = $mainMod, D, exec, app-launcher
      bind = $mainMod, T, exec, system-tray
      bind = $mainMod, B, exec, terminal btop
      bind = $mainMod, Z, exec, zen-toggle
      bind = $mainMod, O, exec, emoji type
      bind = $mainMod SHIFT, B, exec, random-wallpaper
      bind = $mainMod, C, exec, clipboard-picker
      bind = $mainMod SHIFT, C, exec, clipboard-wipe
      bind = $mainMod, M, exec, terminal ncmpcpp

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

      bind = , xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%+
      bind = , xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%-
      bind = , xf86audiomicmute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle
      bind = , xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
      # TODO: lets fill this out
      # bind = , xf86rfkill, exec, airplane mode
      # bind = , xf86brightnessup, exec, brightnessup
      # bind = , xf86brightnessdown, exec, brightnessdown
      # bind = , xf86webcam, exec, webcam
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
      windowrulev2 = tile,class:(Chromium-browser),title:(www.messenger.com_/login)
      windowrulev2 = tile,class:(Chromium-browser),title:(www.discord.com_/login)
      windowrulev2 = float,class:(wlogout),title:(wlogout)
      windowrulev2 = noanim,class:(wlogout),title:(wlogout)
      windowrulev2 = noanim,class:(Rofi),title:(rofi)
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
  home.packages = [ launcher extraConfig startPortals colorPicker ];
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
