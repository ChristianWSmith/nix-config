{ pkgs, fontMono, ... }:
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
        font = "${fontMono}:pixelsize=16";
      };
      colors = {
        alpha=0.8;
        background=111111;
      };
    };
  };
}
