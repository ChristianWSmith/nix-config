{ pkgs, theme, ... }:
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
        font = "${theme.monoFontName}:style=Bold:pixelsize=${builtins.toString theme.fontSizeUI}";
        prompt = ">  ";
        icon-theme = theme.iconThemeName;
        exit-on-keyboard-focus-loss = "no";
      };
      colors = {
        background = "${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyBackgroundHex}";
        text = "${theme.colorScheme.foreground1Hex}ff";
        match = "${theme.colorScheme.dangerHex}${theme.colorScheme.transparencyForegroundHex}";
        selection = "${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}";
        selection-text = "${theme.colorScheme.background1Hex}ff";
        selection-match = "${theme.colorScheme.dangerHex}ff";
        border = "${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}";
      };
      border = {
        width = builtins.toString theme.borderWidth;
        radius = builtins.toString theme.borderRadius;
      };
    };
  };
}
