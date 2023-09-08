{ pkgs, userHome, iconTheme, ... }:
let
  powerMenu = pkgs.writeShellScriptBin "power-menu" ''
    wlogout --layout ${userHome}/.config/wlogout/layout --css ${userHome}/.config/wlogout/style.css
  '';
in
{
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
        background-color: rgba(17, 17, 17, 0.8);
      }
      button {
        margin: 9px;
        color: rgba(255, 255, 255, 1);
        background-color: rgba(17, 17, 17, 0.8);
        border: 1px solid rgba(89, 89, 89, 0.67);
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: 5px;
      }

      button:hover {
        border: 1px solid rgba(51, 204, 255, 0.93);
        outline-style: none;
      }

      #lock {
        background-image: image(url("${userHome}/.config/wlogout/icons/lock.png"));
      }

      #shutdown {
        background-image: image(url("${userHome}/.config/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${userHome}/.config/wlogout/icons/reboot.png"));
      }
    '';
  };
}
