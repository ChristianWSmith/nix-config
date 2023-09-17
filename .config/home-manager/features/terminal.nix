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
    server.enable = true;
    settings = {
      main = {
        font = "${theme.monoFontName}:pixelsize=16";
      };
      colors = {
        alpha=theme.colorScheme.transparencyBackgroundRGB;
        background=theme.colorScheme.background1Hex;
      };
    };
  };
}
