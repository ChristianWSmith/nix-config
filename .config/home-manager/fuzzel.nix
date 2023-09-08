{ pkgs, iconTheme, fontMono, ... }:
let
  appLauncher = pkgs.writeShellScriptBin "app-launcher" ''
    pkill fuzzel
    fuzzel
  '';
  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    pkill fuzzel
    fuzzel -d $@
  '';
  emoji = pkgs.writeShellScriptBin "emoji" ''
    pkill fuzzel
    rofimoji --selector fuzzel --action $1
  '';
  clipboard = pkgs.writeShellScriptBin "clipboard-picker" ''
    pkill fuzzel
    cliphist list | dmenu | cliphist decode | wl-copy
  '';
in
{
  home.packages = [ appLauncher dmenu emoji clipboard ];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "${fontMono}:style=Bold:pixelsize=16";
        prompt = ">  ";
        icon-theme = iconTheme;
        exit-on-keyboard-focus-loss = "no";
      };
      colors = {
        background = "111111cc";
	text = "ffffffff";
	match = "33ccffee";
	selection = "33ccffee";
        selection-text = "000000ff";
	selection-match = "ffffffff";
	border = "33ccffee";
      };
      border = {
        width = 1;
	radius = 5;
      };
    };
  };
}
