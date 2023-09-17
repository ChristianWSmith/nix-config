{ pkgs, ... }:
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
    settings = ''
      {
        "layer": "overlay", // Waybar at top layer
        "position": "top", // Waybar position (top|bottom|left|right)
        "height": 30, // Waybar height (to be removed for auto height)
        "margin": "5px 5px 0px 5px",
        // "width": 1280, // Waybar width
        "spacing": 2, // Gaps between modules (4px)
        // Choose the order of the modules
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["wlr/taskbar"],
        "modules-right": ["tray", "mpd", "pulseaudio", "network", "cpu", "memory", "battery", "clock"],
        // Modules configuration
        "hyprland/workspaces": {
          "disable-scroll": true,
          "all-outputs": false,
          "warp-on-scroll": false,
          "format": "{icon}",
          "format-icons": {
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
          "6": "",
          "7": "7",
          "8": "8",
          "9": "9",
          "10": "10",
          "11": "L",
          "12": "R",
            "urgent": "",
            "focused": "",
            "default": ""
          }
        },
        "wlr/taskbar": {
          "icon-size": 26,
        "sort-by-app-id": true,
        "all-outputs": true
        },
        "mpd": {
          "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
          "format-disconnected": "Disconnected ",
          "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon} Stopped ",
          "unknown-tag": "N/A",
          "interval": 2,
          "consume-icons": {
            "on": " "
          },
          "random-icons": {
            "off": "<span color=\"#f53c3c\"></span> ",
            "on": " "
          },
          "repeat-icons": {
            "on": " "
          },
          "single-icons": {
            "on": "1 "
          },
          "state-icons": {
            "paused": "",
            "playing": ""
          },
          "tooltip-format": "MPD (connected)",
          "tooltip-format-disconnected": "MPD (disconnected)"
        },
        "tray": {
          "spacing": 10
        },
        "clock": {
        "format": "{:%I:%M %p}",
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
          "format-alt": "{:%a %m/%d/%Y}"
        },
        "cpu": {
          "on-click": "terminal btop",
          "format": "{usage}% ",
          "tooltip": false
        },
        "memory": {
          "on-click": "terminal btop",
          "format": "{}% "
        },
        "battery": {
          "states": {
            "warning": 30,
            "critical": 15
          },
          "format": "{capacity}% {icon}",
          "format-charging": "{capacity}% ",
          "format-plugged": "{capacity}% ",
          "format-alt": "{time} {icon}",
          "format-icons": ["", "", "", "", ""]
        },
        "network": {
          "format-wifi": "({signalStrength}%) ",
          "format-ethernet": "󰈀",
          "tooltip-format": "{ifname} via {gwaddr} 󰈀",
          "format-linked": "(No IP) ⚠",
          "format-disconnected": "Disconnected ⚠",
        "on-click": "terminal nmtui"
        },
        "pulseaudio": {
          "format": "{volume}% {icon} {format_source}",
          "format-bluetooth": "{volume}% {icon} {format_source}",
          "format-bluetooth-muted": " {icon} {format_source}",
          "format-muted": " {format_source}",
          "format-source": " {volume}% ",
          "format-source-muted": "",
          "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
          },
          "on-click": "terminal pulsemixer",
        "on-click-right": "pavucontrol"
        }
      }
    '';
    style = ''
      * {
        font-family: Noto Sans;
        font-size: 16px;
        font-weight: bold;
        margin: 0px;
        padding: 0px;
      }

      window#waybar {
        border-radius: 5px;
        background-color: rgba(17, 17, 17, 0.8);
        /* border-bottom: 3px solid rgba(100, 114, 125, 0.5); */
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      window#waybar.termite {
        background-color: #3F3F3F;
      }

      window#waybar.chromium {
        background-color: #000000;
        border: none;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 5px;
        margin: 2px 2px 2px 0px;
        background-color: transparent;
        color: #ffffff;
      }

      #workspaces button {
        padding: 0px 5px;
      }

      button:hover,
      button.active,
      button.focused {
        background: rgba(100, 114, 125, 0.5);
      }

      button.urgent {
        background-color: #eb4d4b;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #idle_inhibitor,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #custom-updates,
      #custom-emoji,
      #custom-colorpicker,
      #custom-powerprofile,
      #custom-screenshot,
      #custom-clipboard,
      #custom-powermenu,
      #tray,
      #mpd { 
        color: #ffffff;
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
