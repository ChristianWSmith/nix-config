# TODO: THEMEING
{ pkgs, theme, ... }:
let
  zenToggle = pkgs.writeShellScriptBin "zen-toggle" ''
    if pgrep waybar; then
      pkill waybar
    else
      waybar & disown
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
        margin = "5px 5px 0px 5px";
        spacing = 2;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["wlr/taskbar"];
        modules-right = ["tray" "pulseaudio" "network" "cpu" "memory" "battery" "clock"];
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
        };
        tray = {
          spacing = 10;
        };
        clock = {
        format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%a %m/%d/%Y}";
        };
        cpu = {
          on-click = "terminal btop";
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          on-click = "terminal btop";
          format = "{}% ";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        network = {
          format-wifi = "({signalStrength}%) ";
          format-ethernet = "󰈀";
          tooltip-format = "{ifname} via {gwaddr} 󰈀";
          format-linked = "(No IP) ⚠";
          format-disconnected = "Disconnected ⚠";
        on-click = "terminal nmtui";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "terminal pulsemixer";
        on-click-right = "pavucontrol";
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
      }

      window#waybar,
      tooltip {
        border-radius: ${builtins.toString theme.borderRadius}px;
        background-color: rgba(${theme.colorScheme.background1RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
        color: #${theme.colorScheme.foreground1Hex};
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: ${builtins.toString theme.borderRadius}px;
        margin: 2px 2px 2px 0px;
        background-color: transparent;
        color: #${theme.colorScheme.foreground1Hex};
      }

      #workspaces button {
        padding: 0px 5px;
      }

      button:hover,
      button.active,
      button.focused {
        background: rgba(${theme.colorScheme.background4RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
      }

      button.urgent {
        background-color: #${theme.colorScheme.dangerHex};
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray,
      #mpd { 
        color: #${theme.colorScheme.foreground1Hex};
        padding: 0 5px;
        margin: 0px 3px;
      }

      #window,
      #workspaces {
      }

      .modules-left {
        margin-left: 2px;
      }

      .modules-right {
        margin-right: 2px;
      }
    '';
  };
  home.packages = with pkgs; [
    nerdfonts
    zenToggle
  ];
}
