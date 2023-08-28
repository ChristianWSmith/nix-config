{ pkgs, ... }:
let
  launcher = pkgs.writeShellScriptBin "terminal" ''
    footclient -E $(which ''${1}) ''${@:2}

  '';
in
{
  home.packages = [ launcher ];
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "Noto Sans Mono:pixelsize=16";
      };
      colors = {
        alpha=0.8;
        background=111111;
      };
    };
  };
}
