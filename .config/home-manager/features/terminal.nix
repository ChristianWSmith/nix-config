{ pkgs, theme, lib, ... }:
let
  launcher = pkgs.writeShellScriptBin "terminal" ''
    if [ "$1" == "" ]
    then
      footclient
    else
      footclient -E $(which $1) ''${@:2}
    fi
  '';
in
{
  home.packages = [ launcher ];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish";
        font = "${theme.monoFontName}:pixelsize=${builtins.toString theme.fontSizeUI}";
      };
      colors = {
        alpha = theme.colorScheme.transparencyBackgroundRGB;
        background = theme.colorScheme.background1Hex;
        regular0 = theme.colorScheme.background1Hex;
        regular1 = theme.colorScheme.redHex;
        regular2 = theme.colorScheme.greenHex;
        regular3 = theme.colorScheme.yellowHex;
        regular4 = theme.colorScheme.blueHex;
        regular5 = theme.colorScheme.magentaHex;
        regular6 = theme.colorScheme.cyanHex;
        regular7 = theme.colorScheme.foreground4Hex;
        bright0 = theme.colorScheme.background4Hex;
        bright1 = theme.colorScheme.redHex;
        bright2 = theme.colorScheme.greenHex;
        bright3 = theme.colorScheme.yellowHex;
        bright4 = theme.colorScheme.blueHex;
        bright5 = theme.colorScheme.magentaHex;
        bright6 = theme.colorScheme.cyanHex;
        bright7 = theme.colorScheme.foreground1Hex;
      };
    };
  };
}
