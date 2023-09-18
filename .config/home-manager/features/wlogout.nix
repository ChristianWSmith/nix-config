{ pkgs, user, theme, ... }:
let
  powerMenu = pkgs.writeShellScriptBin "power-menu" ''
    wlogout --layout ${user.home}/.config/wlogout/layout --css ${user.home}/.config/wlogout/style.css
  '';
in
{
  home.file = {
    ".config/wlogout/icons".source = ../files/wlogout-icons;
  };
  home.packages = [ powerMenu ];
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "gtklock";
        "keybind" = "l";
      }
      {
        "label" = "reboot";
        "action" = "reboot";
        "keybind" = "r";
      } 
      {
        "label" = "shutdown";
        "action" = "poweroff";
        "keybind" = "s";
      }
    ];
    style = ''
      * {
        background-image: none;
      }
      window {
        background-color: rgba(${theme.colorScheme.background1RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
      }
      button {
        margin: 9px;
        color: rgba(${theme.colorScheme.foreground1RGB}, 1);
        background-color: rgba(${theme.colorScheme.background1RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
        border: 1px solid rgba(${theme.colorScheme.background4RGB}, ${theme.colorScheme.transparencyBackgroundRGB});
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: 5px;
      }

      button:hover {
        border: 1px solid rgba(${theme.colorScheme.accentRGB}, ${theme.colorScheme.transparencyForegroundRGB});
        outline-style: none;
      }

      #lock {
        background-image: image(url("${user.home}/.config/wlogout/icons/lock.png"));
      }

      #shutdown {
        background-image: image(url("${user.home}/.config/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${user.home}/.config/wlogout/icons/reboot.png"));
      }
    '';
  };
}
