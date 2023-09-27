{ pkgs, theme, ... }:
let
  zenToggle = pkgs.writeShellScriptBin "zen-toggle" ''
    if pgrep waybar; then
      pkill waybar
      hyprctl keyword general:gaps_in 0
      hyprctl keyword general:gaps_out 0
      hyprctl keyword general:border_size 0
      hyprctl keyword decoration:rounding 0
    else
      waybar & disown
      hyprctl keyword general:gaps_in ${builtins.toString theme.gapsIn}
      hyprctl keyword general:gaps_out ${builtins.toString theme.gapsOut}
      hyprctl keyword general:border_size ${builtins.toString theme.borderWidth}
      hyprctl keyword decoration:rounding ${builtins.toString theme.borderRadius}
    fi
  '';
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "${builtins.toString theme.gapsOut}px ${builtins.toString theme.gapsOut}px 0px ${builtins.toString theme.gapsOut}px";
        spacing = 0;
        modules-left = ["custom/applauncher" "custom/files" "mpd" "hyprland/workspaces"];
        modules-center = ["wlr/taskbar"];
        modules-right = ["tray" "pulseaudio" "network" "battery" "clock" "custom/closewindow" "custom/powermenu"];
        "custom/applauncher" = {
          return-type = "json";
          format = "<span color=\"#${theme.colorScheme.accentHex}\">{}</span>";
          exec = "echo {\\\"text\\\": \\\"󱄅\\\", \\\"tooltip\\\": \\\"Application Launcher\\\"}";
          on-click = "gui-app-launcher";
          on-click-right = "app-launcher";
        };
        "custom/files" = {
          return-type = "json";
          format = "<span color=\"#${theme.colorScheme.foreground1Hex}\">{}</span>";
          exec = "echo {\\\"text\\\": \\\"󰝰\\\", \\\"tooltip\\\": \\\"Files\\\"}";
          on-click = "nemo";
          on-click-right = "terminal ranger";
        };
        "custom/closewindow" = {
          return-type = "json";
          format = "<span color=\"#${theme.colorScheme.warningHex}\">{}</span>";
          exec = "echo {\\\"text\\\": \\\"󰅖\\\", \\\"tooltip\\\": \\\"Close Window\\\"}";
          on-click = "kill -9 $(hyprprop | jq -r '.pid')";
        };
        "custom/powermenu" = {
          return-type = "json";
          format = "<span color=\"#${theme.colorScheme.dangerHex}\">{}</span>";
          exec = "echo {\\\"text\\\": \\\"󰐥\\\", \\\"tooltip\\\": \\\"Power Menu\\\"}";
          on-click = "power-menu";
        };
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            "11" = "L";
            "12" = "R";
          };
        };
        "wlr/taskbar" = {
          icon-size = 26;
          sort-by-app-id = true;
          all-outputs = true;
          on-click = "activate";
          ignore-list = [ "wlogout" ];
        };
        mpd = {
          on-click = "mpdevil";
          on-click-right = "terminal ncmpcpp";
          on-click-middle = "mpc toggle";
          format = "{stateIcon} {consumeIcon} {randomIcon} {repeatIcon} {singleIcon}";
          format-disconnected = "<span color=\"#${theme.colorScheme.dangerHex}\">Disconnected</span>";
          format-stopped = "<span color=\"#${theme.colorScheme.dangerHex}\">󰓛</span> {consumeIcon} {randomIcon} {repeatIcon} {singleIcon}";
          unknown-tag = "N/A";
          interval = 2;
          consume-icons = {
            off = "<span color=\"#${theme.colorScheme.dangerHex}\">󰆐</span>";
            on = "<span color=\"#${theme.colorScheme.successHex}\">󰆐</span>";
          };
          random-icons = {
            off = "<span color=\"#${theme.colorScheme.dangerHex}\">󰒟</span>";
            on = "<span color=\"#${theme.colorScheme.successHex}\">󰒟</span>";
          };
          repeat-icons = {
            off = "<span color=\"#${theme.colorScheme.dangerHex}\">󰕇</span>";
            on = "<span color=\"#${theme.colorScheme.successHex}\">󰕇</span>";
          };
          single-icons = {
            off = "<span color=\"#${theme.colorScheme.dangerHex}\">󰎤</span>";
            on = "<span color=\"#${theme.colorScheme.successHex}\">󰎤</span>";
          };
          state-icons = {
            paused = "<span color=\"#${theme.colorScheme.warningHex}\">󰏤</span>";
            playing = "<span color=\"#${theme.colorScheme.successHex}\">󰐊</span>";
          };
          tooltip-format = "{artist} - {album} - {title}";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        tray = {
          spacing = 0;
          icon-size = 20;
        };
        clock = {
        format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%a %m/%d/%Y}";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "<span color=\"#${theme.colorScheme.successHex}\">󰂄</span>";
          format-plugged = "<span color=\"#${theme.colorScheme.successHex}\">󰂄</span>";
          format-icons = [
            "<span color=\"#${theme.colorScheme.dangerHex}\">󰂎</span>"
            "<span color=\"#${theme.colorScheme.dangerHex}\">󰁺</span>"
            "<span color=\"#${theme.colorScheme.dangerHex}\">󰁻</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰁼</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰁽</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰁾</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰁿</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰂀</span>"
            "<span color=\"#${theme.colorScheme.successHex}\">󰂁</span>"
            "<span color=\"#${theme.colorScheme.successHex}\">󰂂</span>"
            "<span color=\"#${theme.colorScheme.successHex}\">󰁹</span>"
          ];
        };
        network = {
          format-wifi = "{icon}";
          format-ethernet = "<span color=\"#${theme.colorScheme.successHex}\">󰣺</span>";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "<span color=\"#${theme.colorScheme.dangerHex}\">󰣽</span>";
          format-disconnected = "<span color=\"#${theme.colorScheme.dangerHex}\">󰣽</span>";
          on-click = "terminal nmtui";
          format-icons = [
            "<span color=\"#${theme.colorScheme.dangerHex}\">󰣾</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰣴</span>"
            "<span color=\"#${theme.colorScheme.warningHex}\">󰣶</span>"
            "<span color=\"#${theme.colorScheme.successHex}\">󰣸</span>"
            "<span color=\"#${theme.colorScheme.successHex}\">󰣺</span>"
          ];
        };
        pulseaudio = {
          format = "{icon} {format_source}";
          format-bluetooth = "{icon}<span color=\"${theme.colorScheme.cyanHex}\">󰂯</span> {format_source}";
          format-bluetooth-muted = "{icon}<span color=\"${theme.colorScheme.cyanHex}\">󰂯</span> {format_source}";
          format-muted = "<span color=\"#${theme.colorScheme.dangerHex}\">󰝟</span> {format_source}";
          format-source = "<span color=\"#${theme.colorScheme.successHex}\">󰍬</span>";
          format-source-muted = "<span color=\"#${theme.colorScheme.dangerHex}\">󰍭</span>";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄋";
            default = [
              "<span color=\"#${theme.colorScheme.dangerHex}\">󰕿</span>"
              "<span color=\"#${theme.colorScheme.warningHex}\">󰖀</span>"
              "<span color=\"#${theme.colorScheme.successHex}\">󰕾</span>"
            ];
          };
          on-click = "pavucontrol";
          on-click-right = "terminal pulsemixer";
        };
      };
    };
    style = ''
      * {
        font-family: ${theme.fontName};
        font-size: ${builtins.toString theme.fontSizeUI}px;
        font-weight: bold;
        margin: 0px;
        padding: 0px;
  transition: all .2s ease-in-out;
      }

      .modules-left,
      .modules-right,
      window#waybar,
      tooltip {
        border-radius: ${builtins.toString theme.borderRadius}px;
        color: #${theme.colorScheme.foreground1Hex};
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar {
        background-color: rgba(0,0,0,0);
      }

      .modules-left,
      .modules-right,
      tooltip {
        background-color: rgba(${theme.colorScheme.background1RGB}, ${theme.colorScheme.transparencyBackgroundRGB}); 
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #tray,
      #custom-applauncher,
      #custom-files,
      #custom-closewindow,
      #custom-powermenu,
      #mpd,
      #workspaces button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: ${builtins.toString theme.borderRadius}px;
        margin: 2px 1px 2px 1px;
        background-color: transparent;
        color: #${theme.colorScheme.foreground1Hex};
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #tray,
      #custom-applauncher,
      #custom-files,
      #custom-closewindow,
      #custom-powermenu,
      #mpd,
      #workspaces button:hover,
      #workspaces button.active,
      #workspaces button.focused {
        background: rgba(${theme.colorScheme.background4RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
      }

      #workspaces button.urgent {
        background-color: #${theme.colorScheme.dangerHex};
      }
    
      #taskbar button {
        margin: 0px 1px 0px 1px;
      }

      #taskbar button:hover,
      #taskbar button.active,
      #taskbar button.focused {
        background: rgba(${theme.colorScheme.foreground1RGB}, ${theme.colorScheme.transparencyLightShadeRGB});
      }

      #custom-applauncher,
      #custom-files {
        padding: 0px 11px 0px 6px;
      }
      
      
      #custom-closewindow,
      #custom-powermenu {
        padding: 0px 9px 0px 8px;
      }

      #network {
        padding: 0px 12px 0px 7px;
      }

      #tray {
        padding: 0px 5px 0px 5px;
      }

      #mpd {
        padding: 0px 10px 0px 6px;
      }

      #pulseaudio,
      #clock,
      #battery {
        padding: 0px 7px 0px 7px;
      }

      #workspaces button {
        padding: 0px 5px;
      }

      #workspaces button.active,
      #workspaces button.focused {
        padding: 0px 15px;
      }

      .modules-left {
        padding: 0px 1px 0px 1px;
      }

      .modules-right {
        padding: 0px 1px 0px 1px;
      }
    '';
  };
  home.packages = with pkgs; [
    nerdfonts
    zenToggle
  ];
}
