{ pkgs, config, userHome, font, ... }:
let
  launcher = pkgs.writeShellScriptBin "app-launcher" ''
    PIDFILE="/tmp/app-launcher.pid"
    COMMAND="rofi -show drun -theme ${userHome}/.config/rofi/launcher.rasi"
    if ps -p $(cat $PIDFILE);
    then
      pkill -f "$COMMAND"
    else
      echo "$$" > $PIDFILE
      $COMMAND
    fi
  '';

  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    rofi -dmenu $@
  '';
in
{
  home.packages = [ launcher dmenu ];
  programs.rofi.enable = true;


  programs.rofi.theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      
      "*" = {
          background = mkLiteral "#1E2127FF";
          background-alt = mkLiteral "#282B31FF";
          foreground = mkLiteral "#FFFFFFFF";
          selected = mkLiteral "#61AFEFFF";
          active = mkLiteral "#98C379FF";
          urgent = mkLiteral "#E06C75FF";
          font = "${font} 11";
      };
      
    };
}
